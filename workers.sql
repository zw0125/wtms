-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2025 at 03:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobile_lab2`
--

-- --------------------------------------------------------

--
-- Table structure for table `workers`
--

CREATE TABLE `workers` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workers`
--

INSERT INTO `workers` (`id`, `full_name`, `email`, `password`, `phone`, `address`) VALUES
(1, 'Ng Jing Yi', 'ngjingyi@gmail.com', 'jingyi1234@', '0176867456', '88, Lorong Musang King 80, Taman Musang King'),
(7, 'Ng Zi Wei', 'ziweing@gmail.com', '42af59cd200f41c342c7956a97b3872635ffa68d', '01178697658', '88, Lorong Alma Jaya 90'),
(8, 'Janice Lim', 'janice11@gmail.com', '87516c53e764b4592e19eff9156d1a0a7309580a', '0165786573', '99, Lorong Impian 100, Taman Impian'),
(9, 'Karlyn Choo', 'Karlyn@gmail.com', 'cd8532695feba5c046a31819ed8f13d12eaee3e4', '0176867898', 'Taman Durian '),
(10, 'Sunny Heng', 'sunny@gmail.com', 'af148e6ac2239326567055555d6fe6db26f3e868', '0165756678', 'Taman Rambutan'),
(11, 'Ahmad', 'ahmad@gmail.com', 'ab711d2e8871980ab51b457fd1a3078f052f8308', '0165756678', 'Taman Kucing'),
(12, 'Muhamad', 'muhamad@gmail.com', '044c847d2407293c9e6ebfb0ef1cef40c0112c50', '0176578876', 'Taman Ciku'),
(13, 'Vivian Ng', 'vivian@gmail.com', 'f248fc3a53d8de3b3c099a3b200ad388793a0e30', '0176768876', 'Taman Alma Jaya');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
