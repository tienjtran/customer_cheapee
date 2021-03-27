class NotificationItemOutputModel {
  String status;
  String content;
  String time;

  NotificationItemOutputModel(this.status, this.content, this.time);

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getTime => this.time;

  set setTime(time) => this.time = time;
}
