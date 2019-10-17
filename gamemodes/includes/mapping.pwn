/*
					  /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
					 /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
					| $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
					| $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
					| $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
					| $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
					|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
					 \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[MAPPING.PWN]--------------------------------


 * Copyright (c) 2019, Old School Deathmatch
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are not permitted in any case.
 *
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//================= MAPPING AND VEHICLES ================= // CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren=0)

#include "YSI\y_hooks"

hook OnPlayerConnect(playerid) // To remove default objects for players.
{
	RemoveBuildingForPlayer(playerid, 4606, 1825.000, -1413.929, 12.554, 0.250);
	RemoveBuildingForPlayer(playerid, 4594, 1825.000, -1413.929, 12.554, 0.250);
}

stock SpawnMapping()
{
	//============================= Crenshaw Mapping/Vehicles ================================
	CreateVehicle(400, 2133.1780, -1469.7430, 23.8316, 0.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(458, 2133.1843, -1460.5956, 23.9970, 0.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(479, 2133.1682, -1478.3824, 23.2891, 0.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(579, 2128.9045, -1446.4017, 24.0365, 180.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(566, 2129.0002, -1437.9952, 24.4330, 180.0000, 179, 179, 120); // Crenshaw gang
	//=========================================================================================

	//============================= LSPD HQ Mapping/Vehicles ================================
	CreateVehicle(490, 1526.5490, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(490, 1530.4589, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(490, 1534.5389, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(490, 1538.4489, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(426, 1528.1772, -1684.1036, 5.5611, 270.0000, 0, 1, 120, 1);
	CreateVehicle(426, 1528.1772, -1687.9976, 5.5611, 270.0000, 0, 1, 120, 1);
	CreateVehicle(596, 1544.8545, -1651.0107, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.8545, -1654.7867, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.8545, -1658.9757, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.8545, -1662.9667, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1667.7897, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1671.9757, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1675.9797, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1680.2567, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1684.2607, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(541, 1585.3888, -1671.7435, 5.5197, 270.0000, 0, 1, 120, 1);
	CreateVehicle(415, 1585.2844, -1667.6128, 5.7012, 270.0000, 0, 1, 120, 1);
	CreateVehicle(599, 1601.6288, -1683.9128, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1687.7347, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(497, 1568.2406, -1695.4041, 28.5722, 87.1526, 0, 1, 120);
	CreateVehicle(596, 1558.8632, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1570.2662, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1574.4292, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1578.5922, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1583.2982, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1587.4612, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1591.4232, -1710.1427, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1595.4052, -1710.1427, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1691.8977, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1696.0607, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1700.2238, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1704.3868, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(487, 1555.0923, -1609.1469, 13.5979, 180.0000, 0, 1, 120);
	//=========================================================================================

	//============================= Mafia Mapping/Vehicles ================================
	CreateVehicle(580, 1631.5427, -1907.9242, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1635.1395, -1906.4312, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1638.6147, -1905.6790, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1645.6010, -1903.5651, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1642.1191, -1904.6340, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(521, 1648.8828, -1903.7393, 13.2675, 0.0000, 51, 51, 120);
	CreateVehicle(521, 1650.5419, -1903.7823, 13.2675, 0.0000, 51, 51, 120);
	CreateVehicle(579, 1669.3582, -1884.6866, 13.6242, 90.0000, 51, 51, 120);
	CreateVehicle(579, 1669.3582, -1888.6686, 13.6242, 90.0000, 51, 51, 120);
	CreateVehicle(609, 1669.0735, -1895.0786, 13.6302, 90.0000, 51, 51, 120);
	CreateVehicle(487, 1678.8270, -1889.6235, 22.1046, 0.0000, 51, 51, 120);
	//=========================================================================================

	//============================= LSFD Mapping/Vehicles ================================
    CreateVehicle(416, 1180.6284, -1339.0195, 14.0455, 270.0000, 1, 161, 120);
	CreateVehicle(416, 1180.6284, -1309.0284, 14.0455, 270.0000, 1, 161, 120);
	CreateVehicle(560, 1211.8083, -1316.1541, 13.0676, 0.0000, 1, 161, 120, 1);
	CreateVehicle(560, 1211.7893, -1307.9764, 13.0676, 0.0000, 1, 161, 120, 1);
	CreateVehicle(560, 1211.8102, -1324.3580, 13.0676, 0.0000, 1, 161, 120, 1);
	CreateVehicle(487, 1180.3014, -1361.0465, 14.3449, 270.0000, 161, 151, 120);
	//=========================================================================================

	//============================= Piru Mapping/Vehicles ================================
    CreateVehicle(560, 2509.2024, -1670.7142, 12.9876, 0.0000, 43, 43, 120);
	CreateVehicle(560, 2505.7954, -1695.2542, 13.0596, 0.0000, 43, 43, 120);
	CreateVehicle(600, 2473.6863, -1692.5765, 13.2238, 0.0000, 43, 43, 120);
	CreateVehicle(566, 2450.1355, -1664.6355, 13.0938, 90.0000, 43, 43, 120);
	CreateVehicle(566, 2484.3250, -1653.3691, 13.0938, 90.0000, 43, 43, 120);
	CreateVehicle(521, 2513.2896, -1679.7494, 13.0581, 47.0000, 43, 43, 120);
	CreateVehicle(492, 2501.9158, -1656.2000, 13.1235, 76.0000, 43, 43, 120);
	CreateVehicle(487, 2530.7190, -1677.6693, 20.2108, 0.0000, 43, 43, 120);
	//=========================================================================================

	//============================= Strippers Mapping/Vehicles ================================
    CreateVehicle(541, 2436.2551, -1244.2429, 23.6942, 0.0000, 232, 232, 120);
	CreateVehicle(541, 2433.1589, -1244.2429, 23.6942, 0.0000, 232, 232, 120);
	CreateVehicle(541, 2429.9912, -1244.2429, 23.6942, 0.0000, 232, 232, 120);
	CreateVehicle(521, 2426.6526, -1244.2463, 23.5819, 0.0000, 232, 232, 120);
	CreateVehicle(521, 2424.8525, -1244.2463, 23.5819, 0.0000, 232, 232, 120);
	CreateVehicle(521, 2423.3406, -1244.2463, 23.5819, 0.0000, 232, 232, 120);
	CreateVehicle(471, 2406.2358, -1243.0020, 23.3389, 270.0000, 232, 232, 120);
	CreateVehicle(471, 2406.2358, -1241.1300, 23.3389, 270.0000, 232, 232, 120);
	CreateVehicle(560, 2407.3723, -1237.5541, 23.6459, 270.0000, 232, 232, 120);
	CreateVehicle(560, 2407.3723, -1234.3141, 23.6459, 270.0000, 232, 232, 120);
	CreateVehicle(487, 2429.3867, -1232.3993, 25.2995, 90.0000, 232, 232, 120);
	//=========================================================================================

	//============================= Hispanics Mapping/Vehicles ================================
	CreateVehicle(474, 1877.1576, -2021.1320, 13.1105, 180.0000, 135, 135, 120);
	CreateVehicle(474, 1877.1576, -2031.3409, 13.1105, 180.0000, 135, 135, 120);
	CreateVehicle(567, 1877.0907, -2040.6190, 13.2813, 180.0000, 135, 135, 120);
	CreateVehicle(487, 1867.8578, -2000.7408, 18.9879, 270.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2015.4200, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2019.4360, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2023.7030, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2028.4720, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(527, 1888.5768, -2020.2721, 13.1528, 180.0000, 135, 135, 120);
	CreateVehicle(527, 1888.5768, -2030.5631, 13.1528, 180.0000, 135, 135, 120);
	CreateVehicle(535, 1888.7665, -2039.6906, 13.0422, 180.0000, 135, 135, 120);

	CreateObject(5130, 1858.70947, -2020.03076, 14.84350,   0.00000, 0.00000, -225.00000);
	CreateObject(2675, 1868.40820, -2012.94995, 17.94100,   0.00000, 0.00000, 0.00000);
	CreateObject(2675, 1869.18188, -2019.48547, 17.94100,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2009.46960, 17.88041,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2008.48560, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2007.50159, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2006.51758, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2005.53357, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2004.54956, 17.88040,   0.00000, 0.00000, 0.00000);
	//=========================================================================================

	//============================= Pizza Boys Mapping/Vehicles ================================
	CreateVehicle(423, 2122.6035, -1783.0453, 13.3955, 0.0000, 6, 6, 100);
	CreateVehicle(445, 2122.7026, -1775.5262, 13.1546, 0.0000, 6, 6, 100);
	CreateVehicle(448, 2121.5710, -1787.4194, 13.0470, 34.0000, 6, 6, 100);
	CreateVehicle(448, 2121.5710, -1788.9594, 13.0470, 34.0000, 6, 6, 100);
	CreateVehicle(609, 2104.7795, -1782.8207, 13.3800, 0.0000, 6, 6, 100);
	CreateVehicle(579, 2104.8015, -1773.7148, 13.2806, -32.1200, 6, 6, 100);
	//=========================================================================================

	//============================= LSSD MAPPING ================================================

	//Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
	new extsheriffbones;
	extsheriffbones = CreateDynamicObjectEx(18765, 1830.007446, -1434.266235, 14.991260, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18765, 1830.007446, -1424.315551, 14.991260, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18765, 1830.037475, -1444.256591, 10.801260, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(18765, 1830.037475, -1424.294677, 10.801260, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(18765, 1830.007446, -1444.236572, 14.991260, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18765, 1830.037475, -1434.294555, 10.801260, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(18762, 1835.202026, -1421.817749, 17.510643, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1835.202026, -1426.818237, 17.510643, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1835.202026, -1431.818115, 17.510643, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1835.202026, -1436.809570, 17.510643, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1835.202026, -1441.809204, 17.510643, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1835.202026, -1446.801269, 17.510643, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1445.862426, 14.439373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1445.862426, 15.939373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1439.841796, 15.939373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1439.842651, 14.439373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1422.583251, 14.439373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1422.581176, 15.939373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1429.242187, 15.939373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1835.005249, -1429.253906, 14.439373, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(2658, 1835.027465, -1434.095336, 16.143281, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF666633);
	extsheriffbones = CreateDynamicObjectEx(2658, 1835.027465, -1435.596191, 16.143281, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF666633);
	extsheriffbones = CreateDynamicObjectEx(2658, 1835.027465, -1435.596191, 15.753273, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF666633);
	extsheriffbones = CreateDynamicObjectEx(2658, 1835.027465, -1434.095336, 15.753275, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF666633);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.921020, -1434.827514, 16.106618, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(extsheriffbones, 0, "LOS SANTOS", 140, "Ariel", 40, 1, 0xFFFFFFFF, 0x00000000, 1);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.921020, -1434.827514, 15.896617, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(extsheriffbones, 0, "SHERIFF'S DEPARTMENT", 140, "Ariel", 30, 1, 0xFFFFFFFF, 0x00000000, 1);
	extsheriffbones = CreateDynamicObjectEx(18765, 1820.017700, -1444.236572, 14.991259, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18765, 1820.017700, -1434.256347, 14.991259, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18765, 1820.017700, -1444.236572, 19.971244, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1825.004882, -1445.862426, 19.289398, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1825.004882, -1445.862426, 20.779415, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1825.004882, -1442.152465, 20.779415, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1825.004882, -1442.152465, 19.279403, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1822.133666, -1449.232421, 19.279403, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1822.133666, -1449.232421, 20.779415, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1818.213378, -1449.232421, 20.779415, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1818.213378, -1449.232421, 19.279396, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18762, 1825.422363, -1446.731201, 22.630664, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1825.422363, -1441.730590, 22.630664, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1823.421020, -1439.730102, 22.640665, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1816.749755, -1439.730102, 22.640665, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1819.650512, -1439.720092, 22.650665, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(19447, 1832.966186, -1444.414306, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1829.475585, -1444.414306, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1825.975219, -1444.414306, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1816.773559, -1434.082641, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1820.272949, -1434.082641, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1823.762084, -1434.082641, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1827.243408, -1434.082641, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1830.733764, -1434.082641, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1833.694580, -1434.082641, 17.413373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1826.763427, -1424.452636, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1830.253295, -1424.452636, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1833.743896, -1424.462646, 17.403373, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1819.841186, -1440.644775, 17.403373, 360.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1829.452636, -1440.644775, 17.413373, 360.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1829.943115, -1440.644775, 17.403373, 360.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1823.196289, -1444.414184, 22.383388, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1819.696044, -1444.414184, 22.383388, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1816.205566, -1444.414184, 22.383388, 360.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 3475, "vgsn_fncelec_pst", "ws_oldpainted_64", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(18762, 1814.750488, -1442.729736, 22.640665, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1814.760498, -1446.740844, 22.650665, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1817.751708, -1448.742431, 22.640665, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1822.743286, -1448.742431, 22.640665, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1833.201171, -1448.811035, 17.510643, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1828.200195, -1448.811035, 17.510643, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1823.208007, -1448.811035, 17.510643, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1817.517333, -1448.811035, 17.510643, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1820.817382, -1448.821044, 17.510643, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18765, 1820.037963, -1444.256591, 10.801259, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.906860, -1414.482421, 14.310647, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.906860, -1411.273559, 14.310647, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(968, 1834.945678, -1398.911987, 13.082498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, -1, "none", "none", 0xFF000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1830.177978, -1391.354858, 14.126376, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.921020, -1434.827514, 15.706619, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(extsheriffbones, 0, "GLEN PARK STATION", 140, "Ariel", 20, 1, 0xFFFFFFFF, 0x00000000, 1);
	extsheriffbones = CreateDynamicObjectEx(18762, 1833.200561, -1419.806152, 17.500642, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1827.498168, -1419.806152, 17.500642, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1830.410156, -1419.796142, 17.510643, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18765, 1820.007934, -1444.246582, 10.801259, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(18765, 1820.007934, -1434.248291, 10.801259, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(18765, 1829.999023, -1424.298095, 10.801259, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF999966);
	extsheriffbones = CreateDynamicObjectEx(18762, 1815.297241, -1446.810546, 17.510643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1815.297241, -1431.750000, 17.510643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1815.297241, -1436.739379, 17.510643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1815.297241, -1441.810180, 17.510643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1815.287231, -1439.318969, 17.520643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1825.489868, -1421.808593, 17.510643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1825.489868, -1426.798828, 17.510643, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1823.489990, -1429.740356, 17.510643, 90.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1818.288696, -1429.740356, 17.510643, 90.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(18762, 1821.149291, -1429.750366, 17.500642, 90.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0xFF336633);
	extsheriffbones = CreateDynamicObjectEx(19172, 1831.805541, -1449.232788, 14.439373, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1818.244873, -1449.232788, 14.439373, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1825.037719, -1449.232788, 14.439373, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1825.037719, -1449.232788, 15.939373, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1831.808227, -1449.232788, 15.939373, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1818.246582, -1449.232788, 15.939373, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.906860, -1417.692382, 14.310647, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.906860, -1408.062622, 14.310647, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.906860, -1392.881225, 14.130643, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19367, 1834.906860, -1396.092163, 14.130643, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1820.548339, -1391.354858, 14.126376, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1810.919189, -1391.354858, 14.126376, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1786.983398, -1437.946411, 14.296380, 0.000000, 0.000000, 131.899871, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1794.151733, -1431.515014, 14.296380, 0.000000, 0.000000, 131.899871, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1801.319702, -1425.084472, 14.296380, 0.000000, 0.000000, 131.899871, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1805.874145, -1417.188476, 14.296380, 0.000000, 0.000000, 168.099945, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1788.016235, -1442.769287, 14.296380, 0.000000, 0.000000, -109.800216, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1797.076416, -1446.031005, 14.296380, 0.000000, 0.000000, -109.800216, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1806.380126, -1448.125366, 14.296380, 0.000000, 0.000000, -95.600280, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19447, 1815.974121, -1448.585327, 14.296380, 0.000000, 0.000000, -89.900238, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 5449, "chicanotr1_lae", "lasjmfnce1", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(14826, 1814.196777, -1443.295654, 13.068892, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	SetDynamicObjectMaterial(extsheriffbones, 2, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	SetDynamicObjectMaterial(extsheriffbones, 3, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1824.994262, -1424.301757, 15.939373, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	extsheriffbones = CreateDynamicObjectEx(19172, 1824.994262, -1424.301757, 14.439369, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(extsheriffbones, 0, 4828, "airport3_las", "gallery01_law", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	extsheriffbones = CreateDynamicObjectEx(1537, 1835.059692, -1434.836303, 12.507743, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1537, 1835.059692, -1433.345458, 12.507743, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(11245, 1836.024902, -1432.249389, 17.511943, 0.000000, -20.500007, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(11245, 1836.024902, -1420.130859, 17.511943, 0.000000, -20.500007, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(11245, 1836.024902, -1449.031860, 17.511943, 0.000000, -20.500007, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(11245, 1836.024902, -1437.400756, 17.511943, 0.000000, -20.500007, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1256, 1835.444458, -1442.820922, 13.190828, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1256, 1835.444458, -1425.861083, 13.190828, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(5856, 1820.135986, -1429.293945, 14.557785, 0.000000, 0.000000, 450.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(966, 1834.952026, -1398.902099, 12.372496, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1216, 1835.303588, -1432.318481, 13.202507, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1216, 1835.303588, -1431.668212, 13.202507, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1537, 1828.300537, -1419.265869, 12.507742, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1537, 1829.801757, -1419.265869, 12.507742, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(3035, 1821.641113, -1449.933105, 13.309914, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1722, 1814.278442, -1440.163818, 12.590781, 0.000000, 0.000000, 20.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(19831, 1814.705322, -1437.803222, 12.592762, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1722, 1812.989868, -1439.794677, 12.590781, 0.000000, 0.000000, -39.000003, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1226, 1830.285400, -1392.735107, 14.321567, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1226, 1820.684692, -1392.735107, 14.321567, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1226, 1833.534912, -1413.027099, 14.321567, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1691, 1827.544067, -1424.449707, 17.844347, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1691, 1832.204223, -1444.151611, 17.844347, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1688, 1821.595336, -1438.545898, 18.440402, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(2921, 1814.342407, -1439.490478, 22.865255, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(2921, 1814.649536, -1439.243530, 22.865255, 0.000000, 0.000000, -75.300003, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1226, 1807.994995, -1446.948486, 14.321567, 0.000000, 0.000000, 630.000000, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1226, 1792.920654, -1443.132202, 14.321498, 0.000000, -0.099999, -113.199981, 300.00, 300.00);
	extsheriffbones = CreateDynamicObjectEx(1226, 1797.589355, -1430.202026, 14.342391, 0.000000, -0.099999, 134.099990, 300.00, 300.00);
	CreateObject(7096, 1821.3854, -1417.5086, 16.1784, 0.0000, 0.0000, 0.0000); //LSSD STAIRS
	//=========================================================================================

	//==========================LSSD VEHICLES======================
	CreateVehicle(497, 1829.6232, -1430.2673, 18.6598, 270, 16, 1, 120); //Police Maverick
	CreateVehicle(596, 1811.3470, -1394.3189, 13.1294, 270, 16, 1, 120); //LSSD Cruiser
	CreateVehicle(596, 1811.1695, -1399.1054, 13.1377, 270, 16, 1, 120); //LSSD Cruiser
	CreateVehicle(596, 1811.3325, -1404.1970, 13.1514, 270, 16, 1, 120); //LSSD Cruiser
	CreateVehicle(541, 1828.2583, -1394.1286, 13.0439, 180, 16, 1, 120, 1); //LSSDBULLET
	CreateVehicle(596, 1806.9373, -1423.5183, 13.1716, 311.6670, 16, 1, 120); //LSSD Cruiser
	CreateVehicle(415, 1823.0446, -1394.1035, 13.1707, 180, 16, 0, 120, 1); //LSSDCHEETAH

}	