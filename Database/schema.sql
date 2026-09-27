-- =========================================================
-- Heritage House Museum Information Centre Database
-- Relational database schema (7 tables)
-- =========================================================

DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Exhibitions;
DROP TABLE IF EXISTS Artefacts;
DROP TABLE IF EXISTS Donations;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Staff;

-- ---------------------------------------------------------
-- 1. Staff
-- Stores museum employees, including curators and admin staff.
-- ---------------------------------------------------------
CREATE TABLE Staff (
    StaffID         INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName       TEXT NOT NULL,
    LastName        TEXT NOT NULL,
    JobTitle        TEXT NOT NULL,
    Department      TEXT NOT NULL,
    Email           TEXT NOT NULL UNIQUE,
    PhoneNumber     TEXT,
    DateHired       DATE NOT NULL
);

-- ---------------------------------------------------------
-- 2. Members
-- Stores registered museum members/patrons (also used for
-- donors and researchers who create an account).
-- ---------------------------------------------------------
CREATE TABLE Members (
    MemberID        INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName       TEXT NOT NULL,
    LastName        TEXT NOT NULL,
    Email           TEXT NOT NULL UNIQUE,
    PhoneNumber     TEXT,
    Address         TEXT,
    MembershipType  TEXT NOT NULL CHECK (MembershipType IN ('Standard','Student','Senior','Family','Corporate')),
    JoinDate        DATE NOT NULL
);

-- ---------------------------------------------------------
-- 3. Donations
-- Records items or funds donated to the museum, linked to
-- the Member who donated and the Staff member who processed it.
-- ---------------------------------------------------------
CREATE TABLE Donations (
    DonationID      INTEGER PRIMARY KEY AUTOINCREMENT,
    MemberID        INTEGER NOT NULL,
    StaffID         INTEGER NOT NULL,
    DonationType    TEXT NOT NULL CHECK (DonationType IN ('Artefact','Monetary','Document','Artwork')),
    Description     TEXT NOT NULL,
    DonationDate    DATE NOT NULL,
    EstimatedValue  DECIMAL(10,2),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- ---------------------------------------------------------
-- 4. Artefacts
-- The museum's collection items. Each artefact may originate
-- from a donation and is catalogued by a staff member (curator).
-- ---------------------------------------------------------
CREATE TABLE Artefacts (
    ArtefactID      INTEGER PRIMARY KEY AUTOINCREMENT,
    Name            TEXT NOT NULL,
    Category        TEXT NOT NULL CHECK (Category IN ('Historical Artefact','Art','Photograph','Document','Textile')),
    Description     TEXT,
    DateAcquired    DATE NOT NULL,
    Condition       TEXT NOT NULL CHECK (Condition IN ('Excellent','Good','Fair','Poor')),
    StorageLocation TEXT NOT NULL,
    DonationID      INTEGER,
    CuratorStaffID  INTEGER NOT NULL,
    FOREIGN KEY (DonationID) REFERENCES Donations(DonationID),
    FOREIGN KEY (CuratorStaffID) REFERENCES Staff(StaffID)
);

-- ---------------------------------------------------------
-- 5. Exhibitions
-- Exhibitions organised by the museum, each managed by a
-- staff member.
-- ---------------------------------------------------------
CREATE TABLE Exhibitions (
    ExhibitionID    INTEGER PRIMARY KEY AUTOINCREMENT,
    Title           TEXT NOT NULL,
    Description     TEXT,
    StartDate       DATE NOT NULL,
    EndDate         DATE NOT NULL,
    Venue           TEXT NOT NULL,
    ManagedByStaffID INTEGER NOT NULL,
    FOREIGN KEY (ManagedByStaffID) REFERENCES Staff(StaffID)
);

-- ---------------------------------------------------------
-- 6. Loans
-- A linking table recording which artefacts are placed in
-- which exhibitions (many-to-many between Artefacts and
-- Exhibitions), including loan dates and condition checks.
-- ---------------------------------------------------------
CREATE TABLE Loans (
    LoanID          INTEGER PRIMARY KEY AUTOINCREMENT,
    ArtefactID      INTEGER NOT NULL,
    ExhibitionID    INTEGER NOT NULL,
    LoanOutDate     DATE NOT NULL,
    ReturnDate      DATE,
    ConditionOnLoan TEXT NOT NULL CHECK (ConditionOnLoan IN ('Excellent','Good','Fair','Poor')),
    FOREIGN KEY (ArtefactID) REFERENCES Artefacts(ArtefactID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions(ExhibitionID)
);

-- ---------------------------------------------------------
-- 7. Bookings
-- Records tour, event and reading-room bookings made by
-- members, handled by a staff member.
-- ---------------------------------------------------------
CREATE TABLE Bookings (
    BookingID       INTEGER PRIMARY KEY AUTOINCREMENT,
    MemberID        INTEGER NOT NULL,
    StaffID         INTEGER NOT NULL,
    ExhibitionID    INTEGER,
    BookingType     TEXT NOT NULL CHECK (BookingType IN ('Guided Tour','School Group','Reading Room','Venue Hire')),
    BookingDate     DATE NOT NULL,
    NumberOfPeople  INTEGER NOT NULL DEFAULT 1,
    Status          TEXT NOT NULL CHECK (Status IN ('Pending','Confirmed','Cancelled','Completed')) DEFAULT 'Pending',
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions(ExhibitionID)
);
