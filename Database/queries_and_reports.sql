-- =========================================================
-- Queries, Forms (conceptual) and Reports
-- Heritage House Museum Information Centre Database
-- =========================================================

-- QUERY 1: List all artefacts currently on loan to an exhibition,
-- showing which exhibition they are in and the loan-out date.
SELECT
    a.Name            AS Artefact,
    a.Category,
    e.Title           AS Exhibition,
    l.LoanOutDate,
    l.ReturnDate,
    l.ConditionOnLoan
FROM Loans l
JOIN Artefacts a   ON l.ArtefactID = a.ArtefactID
JOIN Exhibitions e ON l.ExhibitionID = e.ExhibitionID
ORDER BY l.LoanOutDate;

-- QUERY 2: Find all bookings for a specific member (parameterised
-- query - replace the email address as needed).
SELECT
    m.FirstName || ' ' || m.LastName AS Member,
    b.BookingType,
    b.BookingDate,
    b.NumberOfPeople,
    b.Status
FROM Bookings b
JOIN Members m ON b.MemberID = m.MemberID
WHERE m.Email = 'sarah.hango@example.com';

-- QUERY 3: Total estimated value of donations received per member,
-- used to identify major donors.
SELECT
    m.FirstName || ' ' || m.LastName AS Donor,
    COUNT(d.DonationID)              AS NumberOfDonations,
    SUM(d.EstimatedValue)            AS TotalEstimatedValue
FROM Donations d
JOIN Members m ON d.MemberID = m.MemberID
GROUP BY m.MemberID
ORDER BY TotalEstimatedValue DESC;

-- QUERY 4: Upcoming exhibitions (starting from today) and the
-- staff member responsible for managing each one.
SELECT
    e.Title,
    e.StartDate,
    e.EndDate,
    e.Venue,
    s.FirstName || ' ' || s.LastName AS ManagedBy
FROM Exhibitions e
JOIN Staff s ON e.ManagedByStaffID = s.StaffID
WHERE e.StartDate >= date('now')
ORDER BY e.StartDate;

-- QUERY 5: Artefacts that are NOT linked to any donation
-- (i.e. acquired by other means such as purchase or transfer).
SELECT Name, Category, DateAcquired, StorageLocation
FROM Artefacts
WHERE DonationID IS NULL;

-- QUERY 6: Count of artefacts per category, used to understand
-- the composition of the collection.
SELECT Category, COUNT(*) AS TotalItems
FROM Artefacts
GROUP BY Category
ORDER BY TotalItems DESC;

-- =========================================================
-- REPORT VIEWS
-- These views act as the basis for printed/exported reports.
-- =========================================================

-- REPORT 1: Exhibition Loan Report - for each exhibition, lists
-- every artefact on loan to it and its condition.
DROP VIEW IF EXISTS ExhibitionLoanReport;
CREATE VIEW ExhibitionLoanReport AS
SELECT
    e.Title       AS Exhibition,
    e.StartDate,
    e.EndDate,
    a.Name        AS Artefact,
    a.Category,
    l.ConditionOnLoan
FROM Exhibitions e
JOIN Loans l     ON e.ExhibitionID = l.ExhibitionID
JOIN Artefacts a ON l.ArtefactID = a.ArtefactID;

-- REPORT 2: Donor Contribution Report - summarises donations
-- received per member/donor.
DROP VIEW IF EXISTS DonorContributionReport;
CREATE VIEW DonorContributionReport AS
SELECT
    m.FirstName || ' ' || m.LastName AS Donor,
    m.MembershipType,
    d.DonationType,
    d.Description,
    d.DonationDate,
    d.EstimatedValue
FROM Donations d
JOIN Members m ON d.MemberID = m.MemberID;

-- REPORT 3: Staff Workload Report - shows how many bookings and
-- exhibitions each staff member manages/handles.
DROP VIEW IF EXISTS StaffWorkloadReport;
CREATE VIEW StaffWorkloadReport AS
SELECT
    s.FirstName || ' ' || s.LastName AS StaffMember,
    s.JobTitle,
    (SELECT COUNT(*) FROM Bookings b WHERE b.StaffID = s.StaffID)      AS BookingsHandled,
    (SELECT COUNT(*) FROM Exhibitions e WHERE e.ManagedByStaffID = s.StaffID) AS ExhibitionsManaged
FROM Staff s;

-- =========================================================
-- FORM NOTE (conceptual):
-- In a GUI database tool (e.g. MS Access / a front-end built on
-- this schema), the following data-entry forms would be created,
-- each bound directly to its table and using drop-down lookups
-- for foreign keys:
--   1. Staff Registration Form      -> Staff table
--   2. Member Registration Form     -> Members table
--   3. Donation Capture Form        -> Donations table (lookup: Members, Staff)
--   4. Artefact Cataloguing Form    -> Artefacts table (lookup: Donations, Staff)
--   5. Exhibition Planning Form     -> Exhibitions table (lookup: Staff)
--   6. Loan Register Form           -> Loans table (lookup: Artefacts, Exhibitions)
--   7. Booking Form                 -> Bookings table (lookup: Members, Staff, Exhibitions)
-- =========================================================
