class Customer {
  String? name;
  String? address;
  int? phoneNumber;
  double? suhuTubuh;
  String? level;
  double? diskon;

  factory Customer(String jenisCustomer, name, address, phoneNumber) {
    if (jenisCustomer == 'vip') {
      return Customer.vip(
          name: name, phoneNumber: phoneNumber, address: address);
    } else if (jenisCustomer == 'reseller') {
      return Customer.reseller(
          name: name, phoneNumber: phoneNumber, address: address);
    } else {
      return Customer.biasa(
          name: name, phoneNumber: phoneNumber, address: address);
    }
  }

  Customer.tanpaAlamat(this.name, this.phoneNumber, suhuPengukuran)
      : suhuTubuh = (9 / 5) * suhuPengukuran + 32 {
    address = 'Jl. Prof. Dr. Hadari Nawawi';
  }

  Customer.reseller({this.name, this.address, this.phoneNumber}) {
    diskon = 20 / 100;
  }

  Customer.vip({this.name, this.address, this.phoneNumber}) {
    diskon = 50 / 100;
  }

  Customer.biasa({this.name, this.address, this.phoneNumber}) {
    diskon = 0;
  }

  void sapa() {
    print('Halo $name apa kabar?');
  }

  void save() {
    print('Data customer telah tersimpan');
  }
}
