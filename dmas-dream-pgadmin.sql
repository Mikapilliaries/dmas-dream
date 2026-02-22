-- =====================================================
-- ROLE
-- =====================================================
CREATE TABLE role (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- =====================================================
-- SYSTEM AGENCY
-- =====================================================
CREATE TABLE system_agency (
    sys_ag_id SERIAL PRIMARY KEY,
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
CREATE TABLE "user" (
    u_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    sys_ag_id INT,
    role_id INT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'active'
        CHECK (status IN ('active','inactive','banned')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sys_ag_id) REFERENCES system_agency(sys_ag_id) ON DELETE SET NULL,
    FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE RESTRICT
);

-- =====================================================
-- RESOURCE
-- =====================================================
CREATE TABLE resource (
    res_id SERIAL PRIMARY KEY,
    sys_ag_id INT NOT NULL REFERENCES system_agency(sys_ag_id) ON DELETE CASCADE
);

-- =====================================================
-- HUMAN RESOURCE
-- =====================================================
CREATE TABLE human_resource (
    hr_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR(50),
    weight REAL CHECK (weight >= 0),
    contact VARCHAR(255),
    capabilities TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available','unavailable','deployed')),
    res_id INT NOT NULL REFERENCES resource(res_id) ON DELETE CASCADE
);

-- =====================================================
-- NON-HUMAN RESOURCE
-- =====================================================
CREATE TABLE non_human_resource (
    nh_res_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    res_id INT NOT NULL REFERENCES resource(res_id) ON DELETE CASCADE
);

-- =====================================================
-- VEHICLE
-- =====================================================
CREATE TABLE vehicle (
    vehicle_id SERIAL PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    plate_number VARCHAR(255) UNIQUE,
    fuel_type VARCHAR(255),
    weight REAL CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available','unavailable','maintenance')),
    nh_res_id INT NOT NULL REFERENCES non_human_resource(nh_res_id) ON DELETE CASCADE
);

-- =====================================================
-- EQUIPMENT
-- =====================================================
CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    source_of_power VARCHAR(255),
    fuel_type VARCHAR(255),
    weight REAL CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available','unavailable','maintenance')),
    nh_res_id INT NOT NULL REFERENCES non_human_resource(nh_res_id) ON DELETE CASCADE
);

-- =====================================================
-- INCIDENT MANAGEMENT TEAM
-- =====================================================
CREATE TABLE incident_management_team (
    imt_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE incident_management_member (
    imt_member_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    agency VARCHAR(255),
    assigned_incident INT,
    u_id INT REFERENCES "user"(u_id) ON DELETE SET NULL,
    imt_id INT NOT NULL REFERENCES incident_management_team(imt_id) ON DELETE CASCADE
);

-- =====================================================
-- DEPLOYMENT AREA
-- =====================================================
CREATE TABLE deployment_area (
    deparea_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE deployment_area_geolocation (
    deparea_geo_id SERIAL PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    deparea_id INT NOT NULL UNIQUE
        REFERENCES deployment_area(deparea_id) ON DELETE CASCADE
);

-- =====================================================
-- PROVINCE
-- =====================================================
CREATE TABLE province (
    prov_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    deparea_id INT REFERENCES deployment_area(deparea_id) ON DELETE SET NULL
);

CREATE TABLE province_geolocation (
    prov_geo_id SERIAL PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    prov_id INT NOT NULL UNIQUE
        REFERENCES province(prov_id) ON DELETE CASCADE
);

-- =====================================================
-- MUNICIPALITY
-- =====================================================
CREATE TABLE municipality (
    muni_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    prov_id INT NOT NULL REFERENCES province(prov_id) ON DELETE CASCADE
);

CREATE TABLE municipality_geolocation (
    muni_geo_id SERIAL PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    muni_id INT NOT NULL UNIQUE
        REFERENCES municipality(muni_id) ON DELETE CASCADE
);

-- =====================================================
-- BARANGAY
-- =====================================================
CREATE TABLE barangay (
    brgy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    muni_id INT NOT NULL REFERENCES municipality(muni_id) ON DELETE CASCADE
);

CREATE TABLE barangay_geolocation (
    brgy_geo_id SERIAL PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    brgy_id INT NOT NULL UNIQUE
        REFERENCES barangay(brgy_id) ON DELETE CASCADE
);

-- =====================================================
-- INCIDENT REPORT
-- =====================================================
CREATE TABLE incident_report (
    ir_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    severity VARCHAR(255) NOT NULL,
    source VARCHAR(255) NOT NULL,
    prov_id INT REFERENCES province(prov_id) ON DELETE SET NULL,
    muni_id INT REFERENCES municipality(muni_id) ON DELETE SET NULL,
    brgy_id INT REFERENCES barangay(brgy_id) ON DELETE SET NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending','validated','resolved','closed')),
    reported_by VARCHAR(255),
    date_reported TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- CHECK-IN PORTAL
-- =====================================================
CREATE TABLE check_in_portal (
    ci_portal_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    ir_id INT NOT NULL REFERENCES incident_report(ir_id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL DEFAULT 'open'
        CHECK (status IN ('open','closed')),
    duration VARCHAR(255),
    check_in_count INT DEFAULT 0 CHECK (check_in_count >= 0),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- DEPLOYMENT
-- =====================================================
CREATE TABLE deployment (
    dep_id SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending','ongoing','completed')),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    ir_id INT REFERENCES incident_report(ir_id) ON DELETE SET NULL,
    deparea_id INT REFERENCES deployment_area(deparea_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN AGENCY
-- =====================================================
CREATE TABLE check_in_agency (
    ci_ag_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    leader VARCHAR(255),
    contact_number VARCHAR(50),
    email VARCHAR(255),
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_portal_id INT NOT NULL REFERENCES check_in_portal(ci_portal_id) ON DELETE CASCADE,
    dep_id INT REFERENCES deployment(dep_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN HUMAN RESOURCE
-- =====================================================
CREATE TABLE check_in_human_resource (
    ci_hr_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR(255),
    weight REAL CHECK (weight >= 0),
    contact VARCHAR(255),
    capabilities TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_ag_id INT NOT NULL REFERENCES check_in_agency(ci_ag_id) ON DELETE CASCADE,
    imt_id INT REFERENCES incident_management_team(imt_id) ON DELETE SET NULL
);

-- =====================================================
-- CHECK-IN NON-HUMAN RESOURCE
-- =====================================================
CREATE TABLE check_in_non_human_resource (
    ci_nhr_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    ci_ag_id INT NOT NULL REFERENCES check_in_agency(ci_ag_id) ON DELETE CASCADE
);

-- =====================================================
-- CHECK-IN VEHICLE
-- =====================================================
CREATE TABLE check_in_vehicle (
    ci_vehicle_id SERIAL PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    plate_number VARCHAR(255) UNIQUE,
    fuel_type VARCHAR(255),
    weight REAL CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_nhr_id INT NOT NULL REFERENCES check_in_non_human_resource(ci_nhr_id) ON DELETE CASCADE
);

-- =====================================================
-- CHECK-IN EQUIPMENT
-- =====================================================
CREATE TABLE check_in_equipment (
    ci_equipment_id SERIAL PRIMARY KEY,
    operator_name VARCHAR(255),
    kind VARCHAR(255),
    type VARCHAR(255),
    source_of_power VARCHAR(255),
    fuel_type VARCHAR(255),
    weight REAL CHECK (weight >= 0),
    contact_or_details VARCHAR(255),
    capabilities_or_specialization TEXT,
    others TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'active',
    ci_nhr_id INT NOT NULL REFERENCES check_in_non_human_resource(ci_nhr_id) ON DELETE CASCADE
);