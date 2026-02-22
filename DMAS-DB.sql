-- =====================================================
-- CREATE DATABASE
-- =====================================================
DROP DATABASE IF EXISTS dream_db;
CREATE DATABASE dream_db;
USE dream_db;

SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- ROLE
-- =====================================================
CREATE TABLE role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- =====================================================
-- SYSTEM AGENCY
-- =====================================================
CREATE TABLE system_agency (
    sys_ag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    muni_id INT,
    brgy_id INT,
    ir_id INT,
    contact_number VARCHAR(50),
    email VARCHAR(255),
    status VARCHAR(50) NOT NULL DEFAULT 'active'
        CHECK (status IN ('active','inactive'))
);

-- =====================================================
-- USER
-- =====================================================
CREATE TABLE user (
    u_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    sys_ag_id INT,
    role_id INT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'active'
        CHECK (status IN ('active','inactive','banned')),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sys_ag_id) REFERENCES system_agency(sys_ag_id) ON DELETE SET NULL,
    FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE RESTRICT
);

-- =====================================================
-- RESOURCE
-- =====================================================
CREATE TABLE resource (
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    sys_ag_id INT NOT NULL,
    FOREIGN KEY (sys_ag_id) REFERENCES system_agency(sys_ag_id) ON DELETE CASCADE
);

-- =====================================================
-- HUMAN RESOURCE
-- =====================================================
CREATE TABLE human_resource (
    hr_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR(50),
    weight FLOAT CHECK (weight >= 0),
    contact VARCHAR(255),
    capabilities TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available','unavailable','deployed')),
    res_id INT NOT NULL,
    FOREIGN KEY (res_id) REFERENCES resource(res_id) ON DELETE CASCADE
);

-- =====================================================
-- NON-HUMAN RESOURCE
-- =====================================================
CREATE TABLE non_human_resource (
    nh_res_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    res_id INT NOT NULL,
    FOREIGN KEY (res_id) REFERENCES resource(res_id) ON DELETE CASCADE
);

-- =====================================================
-- VEHICLE
-- =====================================================
CREATE TABLE vehicle (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    plate_number VARCHAR(255) UNIQUE,
    fuel_type VARCHAR(255),
    weight FLOAT CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available','unavailable','maintenance')),
    nh_res_id INT NOT NULL,
    FOREIGN KEY (nh_res_id) REFERENCES non_human_resource(nh_res_id) ON DELETE CASCADE
);

-- =====================================================
-- EQUIPMENT
-- =====================================================
CREATE TABLE equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    source_of_power VARCHAR(255),
    fuel_type VARCHAR(255),
    weight FLOAT CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available','unavailable','maintenance')),
    nh_res_id INT NOT NULL,
    FOREIGN KEY (nh_res_id) REFERENCES non_human_resource(nh_res_id) ON DELETE CASCADE
);

-- =====================================================
-- INCIDENT MANAGEMENT TEAM
-- =====================================================
CREATE TABLE incident_management_team (
    imt_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE incident_management_member (
    imt_member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    agency VARCHAR(255),
    assigned_incident INT,
    u_id INT,
    imt_id INT NOT NULL,
    FOREIGN KEY (u_id) REFERENCES user(u_id) ON DELETE SET NULL,
    FOREIGN KEY (imt_id) REFERENCES incident_management_team(imt_id) ON DELETE CASCADE
);

-- =====================================================
-- DEPLOYMENT AREA
-- =====================================================
CREATE TABLE deployment_area (
    deparea_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE deployment_area_geolocation (
    deparea_geo_id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    deparea_id INT NOT NULL UNIQUE,
    FOREIGN KEY (deparea_id) REFERENCES deployment_area(deparea_id) ON DELETE CASCADE
);

-- =====================================================
-- PROVINCE
-- =====================================================
CREATE TABLE province (
    prov_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    deparea_id INT,
    FOREIGN KEY (deparea_id) REFERENCES deployment_area(deparea_id) ON DELETE SET NULL
);

CREATE TABLE province_geolocation (
    prov_geo_id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    prov_id INT NOT NULL UNIQUE,
    FOREIGN KEY (prov_id) REFERENCES province(prov_id) ON DELETE CASCADE
);

-- =====================================================
-- MUNICIPALITY
-- =====================================================
CREATE TABLE municipality (
    muni_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    prov_id INT NOT NULL,
    FOREIGN KEY (prov_id) REFERENCES province(prov_id) ON DELETE CASCADE
);

CREATE TABLE municipality_geolocation (
    muni_geo_id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    muni_id INT NOT NULL UNIQUE,
    FOREIGN KEY (muni_id) REFERENCES municipality(muni_id) ON DELETE CASCADE
);

-- =====================================================
-- BARANGAY
-- =====================================================
CREATE TABLE barangay (
    brgy_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    muni_id INT NOT NULL,
    FOREIGN KEY (muni_id) REFERENCES municipality(muni_id) ON DELETE CASCADE
);

CREATE TABLE barangay_geolocation (
    brgy_geo_id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    brgy_id INT NOT NULL UNIQUE,
    FOREIGN KEY (brgy_id) REFERENCES barangay(brgy_id) ON DELETE CASCADE
);

-- =====================================================
-- INCIDENT REPORT
-- =====================================================
CREATE TABLE incident_report (
    ir_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    severity VARCHAR(255) NOT NULL,
    source VARCHAR(255) NOT NULL,
    prov_id INT,
    muni_id INT,
    brgy_id INT,
    status VARCHAR(50) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending','validated','resolved','closed')),
    reported_by VARCHAR(255),
    date_reported DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (prov_id) REFERENCES province(prov_id) ON DELETE SET NULL,
    FOREIGN KEY (muni_id) REFERENCES municipality(muni_id) ON DELETE SET NULL,
    FOREIGN KEY (brgy_id) REFERENCES barangay(brgy_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN PORTAL
-- =====================================================
CREATE TABLE check_in_portal (
    ci_portal_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    ir_id INT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'open'
        CHECK (status IN ('open','closed')),
    duration VARCHAR(255),
    check_in_count INT DEFAULT 0 CHECK (check_in_count >= 0),
    last_update DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ir_id) REFERENCES incident_report(ir_id) ON DELETE CASCADE
);

-- =====================================================
-- DEPLOYMENT
-- =====================================================
CREATE TABLE deployment (
    dep_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending','ongoing','completed')),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    ir_id INT,
    deparea_id INT,
    FOREIGN KEY (ir_id) REFERENCES incident_report(ir_id) ON DELETE SET NULL,
    FOREIGN KEY (deparea_id) REFERENCES deployment_area(deparea_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN AGENCY
-- =====================================================
CREATE TABLE check_in_agency (
    ci_ag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    leader VARCHAR(255),
    contact_number VARCHAR(50),
    email VARCHAR(255),
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_portal_id INT NOT NULL,
    dep_id INT,
    FOREIGN KEY (ci_portal_id) REFERENCES check_in_portal(ci_portal_id) ON DELETE CASCADE,
    FOREIGN KEY (dep_id) REFERENCES deployment(dep_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN HUMAN RESOURCE
-- =====================================================
CREATE TABLE check_in_human_resource (
    ci_hr_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR(255),
    weight FLOAT CHECK (weight >= 0),
    contact VARCHAR(255),
    capabilities TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_ag_id INT NOT NULL,
    imt_id INT,
    FOREIGN KEY (ci_ag_id) REFERENCES check_in_agency(ci_ag_id) ON DELETE CASCADE,
    FOREIGN KEY (imt_id) REFERENCES incident_management_team(imt_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN NON-HUMAN RESOURCE
-- =====================================================
CREATE TABLE check_in_non_human_resource (
    ci_nhr_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    ci_ag_id INT NOT NULL,
    FOREIGN KEY (ci_ag_id) REFERENCES check_in_agency(ci_ag_id) ON DELETE CASCADE
);

-- =====================================================
-- CHECK-IN VEHICLE
-- =====================================================
CREATE TABLE check_in_vehicle (
    ci_vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    plate_number VARCHAR(255) UNIQUE,
    fuel_type VARCHAR(255),
    weight FLOAT CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_nhr_id INT NOT NULL,
    FOREIGN KEY (ci_nhr_id) REFERENCES check_in_non_human_resource(ci_nhr_id) ON DELETE CASCADE
);

-- =====================================================
-- CHECK-IN EQUIPMENT
-- =====================================================
CREATE TABLE check_in_equipment (
    ci_equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    source_of_power VARCHAR(255),
    fuel_type VARCHAR(255),
    weight FLOAT CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_nhr_id INT NOT NULL,
    FOREIGN KEY (ci_nhr_id) REFERENCES check_in_non_human_resource(ci_nhr_id) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS = 1;