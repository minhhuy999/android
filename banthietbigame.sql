-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th2 22, 2023 lúc 10:44 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `banthietbigame`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `iddh` varchar(20) NOT NULL,
  `idsp` varchar(20) NOT NULL,
  `tensp` varchar(50) NOT NULL,
  `dongia` int(11) NOT NULL,
  `soluong` int(11) NOT NULL,
  `diachi` varchar(250) NOT NULL,
  `idkh` varchar(20) NOT NULL,
  `sdt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgiasp`
--

CREATE TABLE `danhgiasp` (
  `idkh` varchar(20) NOT NULL,
  `idsp` varchar(20) NOT NULL,
  `sdt` int(11) NOT NULL,
  `ngaydanhgia` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `donhang`
--

CREATE TABLE `donhang` (
  `iddh` varchar(20) NOT NULL,
  `idkh` varchar(20) NOT NULL,
  `tongtien` int(11) NOT NULL,
  `ngaymua` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menusp`
--

CREATE TABLE `menusp` (
  `idloai` varchar(20) NOT NULL,
  `tenloai` varchar(50) NOT NULL,
  `hinhloai` varchar(250) NOT NULL,
  `mota` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `idsp` varchar(20) NOT NULL,
  `tensp` varchar(50) NOT NULL,
  `chitiet` varchar(250) NOT NULL,
  `danhgia` varchar(250) NOT NULL,
  `dongia` int(11) NOT NULL,
  `idloai` varchar(20) NOT NULL,
  `hinhsp` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `taikhoankhachhang`
--

CREATE TABLE `taikhoankhachhang` (
  `idkh` varchar(20) NOT NULL,
  `tenkh` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `ngaysinh` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `iddh` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD PRIMARY KEY (`iddh`,`idsp`,`idkh`),
  ADD KEY `fr_chitietkh` (`idkh`),
  ADD KEY `fr_chitietsp` (`idsp`);

--
-- Chỉ mục cho bảng `danhgiasp`
--
ALTER TABLE `danhgiasp`
  ADD PRIMARY KEY (`idkh`,`idsp`),
  ADD KEY `fr_sanphamdanhgia` (`idsp`);

--
-- Chỉ mục cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`iddh`,`idkh`),
  ADD KEY `fr_khachhangdh` (`idkh`);

--
-- Chỉ mục cho bảng `menusp`
--
ALTER TABLE `menusp`
  ADD PRIMARY KEY (`idloai`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`idsp`,`idloai`),
  ADD KEY `fr_loai` (`idloai`);

--
-- Chỉ mục cho bảng `taikhoankhachhang`
--
ALTER TABLE `taikhoankhachhang`
  ADD PRIMARY KEY (`idkh`,`iddh`),
  ADD KEY `fr_dh` (`iddh`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `fr_chitietkh` FOREIGN KEY (`idkh`) REFERENCES `taikhoankhachhang` (`idkh`),
  ADD CONSTRAINT `fr_chitietsp` FOREIGN KEY (`idsp`) REFERENCES `sanpham` (`idsp`);

--
-- Các ràng buộc cho bảng `danhgiasp`
--
ALTER TABLE `danhgiasp`
  ADD CONSTRAINT `fr_khachhangdanhgia` FOREIGN KEY (`idkh`) REFERENCES `taikhoankhachhang` (`idkh`),
  ADD CONSTRAINT `fr_sanphamdanhgia` FOREIGN KEY (`idsp`) REFERENCES `sanpham` (`idsp`);

--
-- Các ràng buộc cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `fr_donhangct` FOREIGN KEY (`iddh`) REFERENCES `chitietdonhang` (`iddh`),
  ADD CONSTRAINT `fr_khachhangdh` FOREIGN KEY (`idkh`) REFERENCES `taikhoankhachhang` (`idkh`);

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `fr_loai` FOREIGN KEY (`idloai`) REFERENCES `menusp` (`idloai`);

--
-- Các ràng buộc cho bảng `taikhoankhachhang`
--
ALTER TABLE `taikhoankhachhang`
  ADD CONSTRAINT `fr_dh` FOREIGN KEY (`iddh`) REFERENCES `donhang` (`iddh`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
