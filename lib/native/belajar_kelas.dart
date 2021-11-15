import '../model/customer.dart';

void main() {
  var dian = Customer('vip', 'Dian Prawira', 'Jl. Purnama', 62821111);
  var hafshoh = Customer.tanpaAlamat('Hafshoh binti Dian', 6288888, 35);
  var ismail = Customer.reseller(
      phoneNumber: 6211111, name: 'Ismail', address: 'Jl. Perdamaian');
  print(dian.diskon);
}
