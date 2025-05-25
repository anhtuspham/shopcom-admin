import '../data/config/app_config.dart';

String getText(String key, String text) {
  String? txt = app_config.appKeyValue?.getValue(key);
  if (txt == null) {
    return text;
  } else {
    return txt;
  }
}

class LocalValueKey {
  static String get username => getText("username", "Tài khoản");
  static String get email => getText("email", "Email");
  static String get enterUsername => getText("enterUsername", "Nhập vào tài khoản");
  static String get enterCode => getText("enterCode", "Nhập mã");
  static String get pleaseFillInAllInfo => getText("pleaseFillInAllInfo", "Vui lòng nhập đủ thông tin");
  static String get password => getText("password", "Mật khẩu");
  static String get enterPassword => getText("enterPassword", "Nhập vào mật khẩu");
  static String get login => getText("login", "Đăng nhập");
  static String get loginSuccess => getText("loginSuccess", "Đăng nhập thành công");
  static String get loginFail => getText("loginFail", "Đăng nhập thất bại");
  static String get wellCome => getText("wellCome", "Xin chào");
  static String get logout => getText("logout", "Đăng xuất");
  static String get changePassword => getText("title_change_password_user", "Đổi mật khẩu");
  static String get ok => getText("ok", "OK");
  static String get cancel => getText("cancel", "Hủy");
  static String get extension => getText("extension", "Extension");
  static String get notification => getText("notification", "Thông báo");
  static String get someErrorOccur => getText("someErrorOccur", "Có lỗi xảy ra");
  static String get noInternet => getText("noInternet", "Không có kết nối mạng");
  static String get discountValue => getText("discountValue", "Giảm giá");
  static String get hour => getText("hour", "Giờ");
  static String get lowerCaseHour => getText("lowerCaseHour", "giờ");

  static String get sendTimeout => getText("sendTimeout", "Quá thời gian để thực hiện");

  static String get receiveTimeout => getText("sendTimeout", "Quá thời gian để nhận dữ liệu");

  static String get noData => getText("noData", "Không có dữ liệu");

  static String get connectionTimeout => getText("sendTimeout", "Quá thời gian để kết nối");

  static String get cancelRequest => getText("cancelRequest", "Hủy yêu cầu");

  static String get leavePageConfirm => getText("leavePageConfirm", "Xác nhận rời trang");

  static String get confirm => getText("confirm", "Xác nhận");

  static String get pleaseFillInfo => getText("pleaseFillInfo", "Vui lòng nhập đủ thông tin");

  static String get oldPassword => getText("oldPassword", "Mật khẩu cũ");

  static String get newPassword => getText("newPassword", "Mật khẩu mới");

  static String get confirmNewPassword => getText("confirmNewPassword", "Xác nhận mật khẩu mới");

  static String get editSuccessPassword => getText("editSuccessPassword", "Chỉnh sửa mật khẩu thành công");

  static String get passwordNotMatch => getText("passwordNotMatch", "Mật khẩu mới không trùng nhau");

  static String get pleaseChangePassword => getText("pleaseChangePassword", "Vui lòng thay đổi mật khẩu");

  static String get expirationPassword => getText("expirationPassword", "Mật khẩu đã quá hạn!");

  static String get expiresPassword => getText("expiresPassword", "Mật khẩu sắp quá hạn!");

  static String get search => getText("search", "Tìm kiếm");

  static String get empty => getText("empty", "Trống");

  static String get selectAll => getText("selectAll", "Chọn tất cả");

  static String get data => getText("data", "Dữ liệu");

  static String get addUser => getText("addUser", "Thêm người dùng");

  static String get addSuccessUser => getText("addSuccessUser", "Thêm thành công người dùng");

  static String get editSuccessUser => getText("editSuccessUser", "Chỉnh sửa thành công nguòi dùng");

  static String get deleteSuccessUser => getText("deleteSuccessUser", "Xóa thành công người dùng");

  static String get deleteFailUser => getText("deleteFailUser", "Xóa thất bại người dùng");

  static String get user => getText("screen", "Người dùng");

  static String get des => getText("des", "Mô tả");

  static String get codeUser => getText("codeUser", "Mã người dùng");

  static String get nameUser => getText("nameUser", "Tên người dùng");

  static String get userList => getText("userList", "Danh sách người dùng");

  static String get editUser => getText("editUser", "Sửa người dùng");
  static String get editOrder => getText("editOrder", "Cập nhật tiến độ đơn hàng");

  static String get userName => getText("userName", "Tên người dùng");

  static String get fullName => getText("fullName", "Họ và tên");

  static String get refresh => getText("refresh", "Làm mới");

  static String get deleteConfirm => getText("deleteConfirm", "Bạn có chắc chắn muốn xóa");

  static String get code => getText("code", "Mã");

  static String get name => getText("name", "Tên");

  static String get phone => getText("phone", "Số điện thoại");

  static String get role => getText("role", "Vai trò");

  static String get exportDataFile => getText("exportDataFile", "Xuất file dữ liệu");

  static String get createUser => getText("createUser", "Tạo người dùng");

  static String get deleteUser => getText("deleteUser", "Xóa người dùng");

  static String get onlyEditOne => getText("onlyEditOne", "Một lần chỉ có thể sửa một dữ liệu");

  static String get pleaseSelectToEdit => getText("pleaseSelectToEdit", "Vui lòng chọn dữ liệu để chỉnh sửa");

  static String get pleaseSelectToAdd => getText("pleaseSelectToAdd", "Vui lòng chọn dữ liệu thêm");

  static String get pleaseSelectToRemove => getText("pleaseSelectToRemove", "Vui lòng chọn dữ liệu để xóa");

  static String get editPassword => getText("editPassword", "Chỉnh sửa mật khẩu");

  static String get roleList => getText("roleList", "Danh sách quyền");

  static String get editRole => getText("editRole", "Chỉnh sửa quyền");

  static String get day => getText("day", "Ngày");

  static String get hours => getText("hours", "Giờ");

  static String get minutes => getText("minutes", "Phút");

  static String get timeExpiresPassword => getText("timeExpiresPassword", "Thời hạn mật khẩu còn: ");

  static String get pleaseChangePasswordToUseWeb => getText("pleaseChangePasswordToUseWeb", "Vui lòng đổi mật khẩu để duy trì việc truy cập");

  static String get skip => getText("skip","Bo qua");

  static String get order => getText("order","Đơn hàng");

  static String get orderList => getText("orderList", "Danh sách đơn hàng");

  static String get taskList => getText("taskList", "Danh sách công việc");

  static String get user_start => getText("user_start", "Người dùng thực hiện");

  static String get time_start => getText("time_start", "Thời gian bắt đầu");

  static String get codeName => getText("codeName", "Mã nhân viên");

  static String get codeTask => getText("codeTask", "Mã công việc");
  static String get nameTask => getText("nameTask", "Tên công việc");

  static String get startTask => getText("startTask", "Bắt đầu công việc");

  static String get endTask => getText("endTask", "Kết thúc công việc");
  static String get codeEmployee => getText("codeEmployee", "Mã nhân viên");
  static String get nameEmployee => getText("nameEmployee", "Tên nhân viên");
  static String get codeOrder => getText("codeOrder", "Mã đơn hàng");
  static String get nameOrder => getText("nameOrder", "Tên đơn hàng");
  static String get dayImportOrder => getText("dayGetOrder", "Ngày nhận đơn hàng");
  static String get dayExportOrder => getText("dayExportOrder", "Dự kiến giao hàng");
  static String get note => getText("note", "Ghi chú");
  static String get manageTask => getText("manageTask", "Thông tin công việc");
  static String get noPermission => getText("noPermission", "Không có quyền thao tác");
  static String get youDontHavePermission => getText("noPermission", "Bạn không thể thao tác với công việc ngay lúc này");
  static String get totalTime => getText("totalTime", "Tổng thời gian thực hiện");
  static String get report => getText("report", "Báo cáo");
  static String get draw => getText("draw", "Bản vẽ");
  static String get jobList => getText("jobList", "Danh sách công việc");
  static String get timeBegin => getText("timeBegin", "Thời gian bắt đầu");
  static String get timeEnd => getText("timeEnd", "Thời gian kết thúc");
  static String get totalHour => getText("totalHour", "Tổng giờ thực hiện");
  static String get totalHourOrder => getText("totalHourOrder", "Tổng giờ đơn hàng");
  static String get totalHourDraw => getText("totalHourDraw", "Tổng giờ bản vẽ");
  static String get infoDraw => getText("infoDraw", "Thông tin bản vẽ");
  static String get codeDraw => getText("codeDraw", "Số bản vẽ");
  static String get nameDraw => getText("nameDraw", "Tên bản vẽ");

  static String get stopJobSuccess => getText("stopJobSuccess", "Dừng công việc thành công");
  static String get stopJobFail => getText("stopJobFail", "Dừng công việc thất bại");
  static String get startJobSuccess => getText("stopJobSuccess", "Bắt đầu công việc thành công");
  static String get startJobFail => getText("stopJobFail", "Bắt đầu công việc thất bại");
  static String get infoOrder => getText("infoOrder", "Thông tin đơn hàng");
  static String get numberOrder => getText("numberOrder", "Số đơn hàng");
  static String get drawList => getText("drawList", "Danh sách bản vẽ");
  static String get timeReceiveOrder => getText("timeReceiveOrder", "Thời gian tiếp nhận đơn hàng");
  static String get receiveOrder => getText("receiveOrder", "Tiếp nhận đơn hàng");
  static String get timeEstimatedDelivery => getText("timeEstimatedDelivery", "Thời gian giao đơn hàng");
  static String get estimatedDelivery => getText("estimatedDelivery", "Giao đơn hàng");
  static String get dayBegin => getText("dayBegin", "Ngày bắt đầu");
  static String get dayEnd => getText("dayEnd", "Ngày kết thúc");
  static String get codeNotExists => getText("codeNotExists", "Mã nhân viên không tồn tại");
  static String get summaryDrawTime => getText("summaryDrawTime", "Tóm tắt thời gian thực hiện bản vẽ");
  static String get summaryOrderTime => getText("summaryOrderTime", "Tóm tắt thời gian thực hiện đơn hàng");


  static String get reportJob => getText("reportJob", "Báo cáo công việc");
  static String get reportStaff => getText("reportStaff", "Báo cáo nhân viên");
  static String get reportOrder => getText("reportOrder", "Báo cáo đơn hàng");
  static String get beginDayMustBeforeEndDay => getText("beginDayMustBeforeEndDay", "Ngày bắt đầu phải nhỏ hơn ngày kết thúc");
  static String get beginDay => getText("beginDay", "Ngày bắt đầu");
  static String get endDayMustAfterBeginDay => getText("endDayMustAfterBeginDay", "Ngày kết thúc phải sau ngày bắt đầu");
  static String get endDay => getText("endDay", "Ngày kết thúc");
  static String get timeConfirmOrder => getText("timeConfirmOrder", "Thời gian xác nhận đơn hàng");
  static String get confirmOrder => getText("confirmOrder", "Xác nhận đơn hàng");
  static String get codeCustomer => getText("codeCustomer", "Mã khách hàng");
  static String get nameCustomer => getText("nameCustomer", "Tên khách hàng");
  static String get contactCustomer => getText("contactCustomer", "Liên hệ khách hàng");

  static String get timeOrder => getText("timeOrder", "Thời gian đơn hàng");
  static String get timeElapsed => getText("timeElapsed", "Time elapsed");
  static String get historyJob => getText("historyJob", "Lịch sử công việc");
  static String get infoJob => getText("infoJob", "Thông tin công việc");
  static String get codeJob => getText("codeJob", "Mã công việc");
  static String get nameJob => getText("nameJob", "Tên công việc");
  static String get stop => getText("stop", "STOP");
  static String get start => getText("start", "START");
  static String get summaryTimeJob => getText("summaryTimeJob",  "Tóm tắt thời gian thực hiện công việc");
  static String get area => getText("area",  "Khu vực");
  static String get listDepartment => getText("listDepartment",  "Danh sách phòng ban");
  static String get deleteDepartment => getText("deleteDepartment",  "Xóa phòng ban");
  static String get department => getText("department",  "Phòng ban");
  static String get deleteSuccessDepartment => getText("deleteSuccessDepartment",  "Xóa phòng ban thành công");
  static String get deleteFailDepartment => getText("deleteFailDepartment",  "Xóa phòng ban thất bại");
  static String get codeDepartment => getText("codeDepartment",  "Mã phòng ban");
  static String get editDepartment => getText("editDepartment",  "Chỉnh sửa phòng ban");
  static String get createDepartment => getText("createDepartment",  "Thêm phòng ban");
  static String get addSuccessDepartment => getText("addSuccessDepartment",  "Thêm phòng ban thành công");
  static String get editSuccessDepartment => getText("editSuccessDepartment",  "Chỉnh sửa phòng ban thành công");
  static String get nameDepartment => getText("nameDepartment",  "Tên phòng ban");
  static String get createJob => getText("createJob",  "Tạo công việc");
  static String get editJob => getText("editJob",  "Chỉnh sửa công việc");
  static String get editSuccessJob => getText("editSuccessJob",  "Chỉnh sửa công việc thành công");
  static String get deleteJob => getText("deleteJob",  "Xóa công việc");
  static String get job => getText("job",  "Công việc");
  static String get deleteSuccessJob => getText("deleteSuccessJob",  "Xóa công việc thành công");
  static String get deleteFailJob => getText("deleteFailJob",  "Xóa công việc thất bại");
  static String get addSuccessJob => getText("addSuccessJob",  "Thêm công việc thành công");
  static String get listJobs => getText("listJobs",  "Danh sách công việc");
  static String get invalidAccount => getText("invalidAccount", "Tài khoản không tồn tại");
  static String get noPermissionToAccess => getText("noPermissionToAccess", "Không có quyền truy cập");
  static String get sessionExpired => getText("sessionExpired", "Hết phiên đăng nhập. Vui lòng đăng nhập lại");
  static String get chooseMonth => getText("chooseMonth", "Tháng");
  static String get chooseQuarter => getText("chooseQuarter", "Quý");
  static String get chooseYear => getText("chooseYear", "Năm");
  static String get filter => getText("filter", "Lọc");
  static String get chooseWeek=> getText("chooseWeek", "Tuần");
  static String get weekNow => getText("weekNow", "Tuần hiện tại");
  static String get quarterNow => getText("quarterNow", "Quý hiện tại");
  static String get monthNow=> getText("monthNow", "Tháng hiện tại");
  static String get yearNow=> getText("yearNow", "Năm hiện tại");

  static String get detailInfo => getText("detailInfo", "Chi tiết thông tin");
  static String get successExport => getText("successExport", "Hoàn thành xuất hàng");
  static String get deleteFailCoupon => getText("deleteFailCoupon", "Xóa coupon thất bại");
  static String get deleteSuccessCoupon => getText("deleteSuccessCoupon", "Xóa coupon thành công");
  static String get updateSuccessOrder => getText("updateSuccessOrder", "Cập nhật đơn hàng thành công");
  static String get updateFailOrder => getText("updateFailOrder", "Cập nhật đơn hàng thất bại");
  static String get numberAWB => getText("numberAWB", "Số AWB");
  static String get nameProduct => getText("nameProduct", "Tên sản phẩm");
  static String get quantity => getText("quantity", "Số lượng");
  static String get material => getText("material", "Vật liệu");
  static String get size => getText("size", "Kích thước");
  static String get releaseDate => getText("releaseDate", "Ngày phát hành");
  static String get shipmentDate => getText("shipment", "Ngày xuất hàng");
  static String get plating => getText("plating", "Mạ");
  static String get coating => getText("coating", "Mạ");
  static String get week => getText("week", "Tuần");
  static String get month => getText("month", "Tháng");
  static String get year => getText("year", "Năm");
  static String get quarter => getText("quarter", "Quý");
  static String get numberDraw => getText("numberDraw", "Số bản vẽ");

  static String get settingPrintQRCode => getText("settingPrintQRCode", "Thiết lập in mã QR");
  static String get numberPrint => getText("numberPrint", "Số lượng in");
  static String get layout => getText("layout", "Bố cục");
  static String get space => getText("space", "Khoảng cách");
  static String get portrait => getText("portrait", "Dọc");
  static String get landscape => getText("landscape", "Ngang");
  static String get previewQrCode => getText("previewQrCode", "Xem trước mã QR");
  static String get print => getText("print", "In");
  static String get qrCode => getText("qrCode", "Mã QR");
  static String get numberColumn => getText("numberColumn", "Số cột");
  static String get numberRow => getText("numberRow", "Số dòng");
  static String get count => getText("count", "Số lượng");
  static String get marginTop => getText("marginTop", "Khoảng cách trên");
  static String get marginBot => getText("marginBot", "Khoảng cách dưới");
  static String get marginLeft => getText("marginLeft", "Khoảng cách trái");
  static String get marginRight => getText("marginRight", "Khoảng cách phải");
  static String get arrangeLayout => getText("arrangeLayout", "Sắp xếp bố cục");
  static String get previewLayout => getText("previewLayout", "Xem trước bố cục");

  static String get deliveryTime => getText("deliveryTime", "Nhận đơn hàng");
  static String get acceptedTime => getText("acceptedTime", "Xuất hàng");
  static String get numberStaff => getText("numberStaff", "Số nhân viên");
  static String get fullNameStaff => getText("fullNameStaff", "Họ tên nhân viên");
  static String get fileNameReportStaff => getText("fileNameReportStaff", "BaoCaoNhanVien");
  static String get fileNameReportJob => getText("fileNameReportJob", "BaoCaoCongViec");
  static String get fileNameReportOrder => getText("fileNameReportOrder", "BaoCaoDonHang");
  static String get fileNameUserList => getText("fileNameUserList", "DanhSachNguoiDung");
  static String get fileNameRoleList => getText("fileNameRoleList", "DanhSachVaiTro");
  static String get fileNameDepartmentList => getText("fileNameDepartmentList", "DanhSachBoPhan");
  static String get fileNameJobList => getText("fileNameJobList", "DanhSachQuyTrinh");
  static String get no => getText("no", "STT");
  static String get copy => getText("copy", "Sao chép");
  static String get addCoupon => getText("addCoupon", "Thêm mã giảm giá");
  static String get editCoupon => getText("editCoupon", "Cập nhật mã giảm giá");

}
