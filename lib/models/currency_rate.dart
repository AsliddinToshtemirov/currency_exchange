class CurrencyRate {
  String? title;
  String? code;
  String? cb_price;
  String? buy_price;
  String? cell_price;
  String? date;
  CurrencyRate(this.title, this.code, this.cb_price, this.buy_price,
      this.cell_price, this.date);

  CurrencyRate.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
    cb_price = json['cb_price'];
    buy_price = json['nbu_buy_price'];
    cell_price = json['nbu_cell_price'];
    date = json['date'];
  }
}
