void main() {
  String alamat = "https://jsonplaceholder.typicode.com/posts/1";
  var uriku = Uri.parse(alamat);
  print(uriku.origin);
}
