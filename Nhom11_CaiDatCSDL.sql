create database QUANLYSV
go

use QUANLYSV
go 

create table TAIKHOAN(
	TenDangNhap nvarchar(20) primary key,
	MatKhau nvarchar(20),
	VaiTro nvarchar(20)
)
 

create table KHOA(
	MaKhoa nvarchar(20) primary key,
	TenKhoa nvarchar(100)
)
create table NGANH(
	MaNganh nvarchar(20) primary key,
	TenNganh nvarchar(100),
	MaKhoa nvarchar(20),
constraint NganhThuocKhoa foreign key(MaKhoa) references KHOA(MaKhoa) on delete set null on update cascade
)


create table VIPHAM(
	MaVP nvarchar(10) primary key,
	NoiDung nvarchar(100)
)


create table GIANGVIEN(
	MaGV nvarchar(20) primary key,
	HoTenGV nvarchar(100),
	MaKhoa nvarchar(20),
	constraint TaiKhoanGV foreign key(MaGV) references TAIKHOAN(TenDangNhap) on delete cascade,
	constraint GVThuocKhoa foreign key(MaKhoa) references KHOA(MaKhoa)
)

create table QUANLY(
	MaQL nvarchar(20) primary key,
	TenNQL nvarchar(100)
	constraint TaiKhoanQL foreign key(MaQL) references TAIKHOAN(TenDangNhap) on delete cascade
)



create table CTDAOTAO(
	MaCTDT nvarchar(20) primary key,
	TenCTDT nvarchar(50),
	HinhThucDT nvarchar(50),
	NgonNguDT nvarchar(50),
	TrinhDoDaoTao nvarchar(50)
)

create table LOP(
	MaLop nvarchar(20) primary key,
	TenLop nvarchar(50),
	MaNganh nvarchar(20),
	MaCTDT nvarchar(20),
	constraint LopThuocNganh foreign key(MaNganh) references NGANH(MaNganh) on delete set null on update cascade,
	constraint LopThuocCTDT foreign key(MaCTDT) references CTDAOTAO(MaCTDT) on delete set null on update cascade
)

create table SINHVIEN(
	MaSV nvarchar(20) primary key,
	HoTenSV nvarchar(100),
	GioiTinh nvarchar(3),
	NgaySinh date,
	MaLop nvarchar(20),
	TinhTrangVP nvarchar(10),
	constraint SVThuocLop foreign key(MaLop) references LOP(MaLop) on delete set null on update cascade,
	constraint SVViPham foreign key(TinhTrangVP) references VIPHAM(MaVP) on update cascade,
	constraint TaiKhoanSV foreign key(MaSV) references TAIKHOAN(TenDangNhap) on delete cascade
)


create table MONHOC(
	MaMH nvarchar(20) primary key,
	TenMH nvarchar(100),
	SoTinChi int
)

create table MONHOC_DAOTAO(
	MaMHDT nvarchar(20) primary key,
	MaMH nvarchar(20),
	MaCTCT nvarchar(20),
	MaNganh nvarchar(20),
	constraint CuaMonHoc foreign key(MaMH) references MONHOC(MaMH) on delete cascade,
	constraint CuaCTCT foreign key(MaCTCT) references CTDAOTAO(MaCTDT) on delete cascade,
	constraint CuaNganh foreign key(MaNganh) references Nganh(MaNganh) on delete cascade)

create table LOPHOC(
	MaLopHoc nvarchar(20) primary key,
	MaMHDT nvarchar(20),
	MaGV nvarchar(20),
	GioiHan int,
	TenPhong nvarchar(20),
	Thu nvarchar(20),
	TietBatDau int,
	TietKetThuc int,
	ThoiGianBatDau date,
	ThoiGianKetThuc date,
	HocKy nvarchar(5),
	Nam date,
	constraint CoMonHoc foreign key(MaMHDT) references MONHOC_DAOTAO(MaMHDT) on delete cascade,
	constraint CuaGiangVien foreign key(MaGV) references GIANGVIEN(MaGV) on delete set null
)

create table DANGKY(
	MaSV nvarchar(20),
	MaLopHoc nvarchar(20),
	primary key(MaSV,MaLopHoc),
	constraint CuaSinhVien foreign key(MaSV) references SINHVIEN(MaSV) on delete cascade,
	constraint CuaLopHoc foreign key(MaLopHoc) references LOPHOC(MaLopHoc) on delete cascade
)
