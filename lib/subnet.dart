import 'dart:io';
import 'dart:math';

void run() {

  stdout.write('Enter the ipv4 address: ');
  String ipAddress = stdin.readLineSync()!;
  List<int> ip = [];
  for(String i in ipAddress.split('.')) {
    ip.add(int.parse(i));
  }

  Map<String, List<int>> ipClass = {'a' : [0,126], 'b' : [128,191], 'c' : [192,223]};
  String ipClassType = '';
  if(ip[0] >= ipClass['a']![0] && ip[0] <= ipClass['a']![1]) {
    ipClassType = 'a';
  } else if(ip[0] >= ipClass['b']![0] && ip[0] <= ipClass['b']![1]) {
    ipClassType = 'b';
  } else if(ip[0] >= ipClass['c']![0] && ip[0] <= ipClass['c']![1]) {
    ipClassType = 'c';
  } else {
    print('Invalid IP');
    return;
  }

  print('IP Class: Class $ipClassType');

  print('press 1 for sub-network, press 2 for CIDR notation, press 3 for no.of host');
  int select = int.parse(stdin.readLineSync()!);

  int need = 0;
  List<int> subnet = [];
  if(select == 1) {
    stdout.write('Enter the sub-net need: ');
    need = int.parse(stdin.readLineSync()!);
    subnet = bySubnet(need,ipClassType);
  } else if(select == 2) {
    stdout.write('Enter the /');
    need = int.parse(stdin.readLineSync()!);
    subnet = byCIRD(need);
  } else if(select == 3) {
    stdout.write('Enter the no.of host need: ');
    need = int.parse(stdin.readLineSync()!);
    subnet = byHost(need,ipClassType);
  } else {
    print('Invalid Operation');
    return;
  }
  
  if(subnet.length == 1) return;

  int jump = subnet[0],sub = subnet[1], ipType = subnet[2];
  print('Sub-networks: $sub');
  List<int> newIp = [ip[0],ipType == 1 ? 0 : ip[1], ipType == 1 || ipType == 2 ? 0 : ip[2], ipType == 1 || ipType == 2 || ipType == 3 ? 0 : ip[3]];
  
  for(int i = 0; i < sub;i++) {
    if(ipType == 1) {
      print('Network Ip : ${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]}');
      print('First Ip   : ${newIp[0]}.${newIp[1] + 1}.${newIp[2]}.${newIp[3]}');
      newIp[1] += jump;
      print('Last Ip    : ${newIp[0]}.${newIp[1] - 1}.${newIp[2]}.${newIp[3]}');
      print('Broadcast  : ${newIp[0]}.${newIp[1]++}.255.255');
    } else if(ipType == 2) {
      print('Network Ip : ${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]}');
      print('First Ip   : ${newIp[0]}.${newIp[1]}.${newIp[2] + 1}.${newIp[3]}');
      newIp[2] += jump;
      print('Last Ip    : ${newIp[0]}.${newIp[1]}.${newIp[2] - 1}.${newIp[3]}');
      print('Broadcast  : ${newIp[0]}.${newIp[1]}.${newIp[2]++}.255');
    } else if(ipType == 3) {
      print('Network Ip : ${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]}');
      print('First Ip   : ${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3] + 1}');
      newIp[3] += jump;
      print('Last Ip    : ${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3] - 1}');
      print('Broadcast  : ${newIp[0]}.${newIp[1]}.${newIp[2]}.${newIp[3]++}');
    }
    print('----------------');
  }


}

List<int> bySubnet(int sNet, String ipClass) {
  List<int> twoPower = [128,64,32,16,8,4,2,1];
  if(twoPower.contains(sNet)) {
    int n = 7-twoPower.indexOf(sNet);
    int ipType = ipClass == 'a' ? 1 : ipClass == 'b' ? 2 : ipClass == 'c' ? 3 : 0;
    int cird = ipType*8+n;
    return byCIRD(cird);
  } else {
    print('Invalid Subnet');
  }
  return [-1];
}

List<int> byCIRD(int cIRD) {
  List<int> twoPower = [128, 64, 32, 16, 8, 4, 2, 1];
  if (cIRD >= 0 && cIRD <= 32) {
    int n = cIRD;
    while (n > 7) {
      n -= 8;
    }
    int jump = 0;
    for (int i = n; i < 8; i++) {
      jump += twoPower[i];
    }
    int ipType = cIRD >= 24 ? 3 : cIRD >= 14 ? 2 : cIRD >= 8 ? 1 : 0; 
    print('CIDR: /$cIRD');
    newSubnetMask(cIRD);
    print('Host per sub-net: ${pow(2,(32 - cIRD))-2}');
    return [jump,pow(2,n).toInt(),ipType];
  } else {
    print('Invalid Notation');
  }
  return [-1];
}

List<int> byHost(int hNet,String classType) {
  int n = 0;
  int host = classType == 'a' ? 255*255*255 : classType == 'b' ? 255*255 : 255;
  if( hNet > 1 && host >= hNet) {
    for(int i = 0; i < 32; i++) {
      if((pow(2, i)-2) >= hNet) {
        n = 32 - i;
        break;
      }
    }
    return byCIRD(n);
  } else {
    print('Invalid Host');
  }
  return [-1];
}

void newSubnetMask(int cIRD) {
  List<int> twoPower = [128, 64, 32, 16, 8, 4, 2, 1];
  int time = cIRD~/8;
  int rem = cIRD%8;
  List<int> mask = [0,0,0,0];
  for(int i=0;i<time;i++) mask[i] = 255;
  for(int i=0;i<rem;i++) {
      mask[time] += twoPower[i];
  }  
  print('Subnet Mask = ${mask.join('.')}');
}