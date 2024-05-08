void main() {
  var myFuture = Future(() {
    return 'Hello';
  });
  print('This runs first!');
  // myFuture.then((result) => print(result));
  myFuture.then((result) => print(result)).catchError((error) {
    //...
  }).then((_) {
    print('After the first then');
  });
  print('This also runs before the future is done!');
}
