class BitkubUserOrderHistoryPaginationDao{
  int page;
  int last;
  int next;
  int prev;

  BitkubUserOrderHistoryPaginationDao({this.page, this.last, this.next, this.prev});

  BitkubUserOrderHistoryPaginationDao.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    last = json['last'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['last'] = this.last;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}