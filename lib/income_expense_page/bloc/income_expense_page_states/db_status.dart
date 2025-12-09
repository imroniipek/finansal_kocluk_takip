
enum PageStatus{idle,loading,success,error}

class DbStatus
{
  final PageStatus status;
  DbStatus({required this.status});
  DbStatus copyWith(PageStatus ? status) =>DbStatus(status: status ??this.status);
}