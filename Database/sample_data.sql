-- =========================================================
-- Sample records for Heritage House Museum Information Centre
-- =========================================================

-- Staff
INSERT INTO Staff (FirstName, LastName, JobTitle, Department, Email, PhoneNumber, DateHired) VALUES
('Anna', 'Shikongo', 'Chief Curator', 'Curatorial', 'anna.shikongo@heritagehousemuseum.org', '0811234561', '2018-03-01'),
('Johannes', 'Nakale', 'Collections Officer', 'Curatorial', 'johannes.nakale@heritagehousemuseum.org', '0811234562', '2019-07-15'),
('Ruth', 'Amupolo', 'Front Desk Coordinator', 'Visitor Services', 'ruth.amupolo@heritagehousemuseum.org', '0811234563', '2021-01-10'),
('Petrus', 'Kavendjii', 'Exhibitions Manager', 'Programmes', 'petrus.kavendjii@heritagehousemuseum.org', '0811234564', '2017-05-20'),
('Maria', 'Van Wyk', 'Research Librarian', 'Research Support', 'maria.vanwyk@heritagehousemuseum.org', '0811234565', '2020-09-01');

-- Members
INSERT INTO Members (FirstName, LastName, Email, PhoneNumber, Address, MembershipType, JoinDate) VALUES
('Sarah', 'Hango', 'sarah.hango@example.com', '0821112221', '14 Independence Ave, Windhoek', 'Standard', '2022-02-14'),
('David', 'Muller', 'david.muller@example.com', '0821112222', '5 Klein Windhoek Rd, Windhoek', 'Student', '2023-05-03'),
('Grace', 'Iyambo', 'grace.iyambo@example.com', '0821112223', '22 Eros Park, Windhoek', 'Family', '2021-11-19'),
('Thomas', 'Beukes', 'thomas.beukes@example.com', '0821112224', '8 Ludwigsdorf St, Windhoek', 'Senior', '2020-06-30'),
('Lena', 'Katjivena', 'lena.katjivena@example.com', '0821112225', '3 Olympia Rd, Windhoek', 'Corporate', '2024-01-08');

-- Donations
INSERT INTO Donations (MemberID, StaffID, DonationType, Description, DonationDate, EstimatedValue) VALUES
(1, 2, 'Artefact', 'Hand-carved wooden chest, early 1900s', '2022-08-10', 4500.00),
(3, 2, 'Document', 'Collection of family letters, 1930s-1950s', '2023-02-22', 800.00),
(4, 1, 'Artwork', 'Oil painting of Windhoek railway station', '2021-09-05', 12000.00),
(5, 1, 'Monetary', 'Cash donation towards conservation fund', '2024-03-15', 5000.00);

-- Artefacts
INSERT INTO Artefacts (Name, Category, Description, DateAcquired, Condition, StorageLocation, DonationID, CuratorStaffID) VALUES
('Carved Wooden Chest', 'Historical Artefact', 'Hand-carved storage chest, early 1900s', '2022-08-15', 'Good', 'Gallery 1 - Case 3', 1, 2),
('Family Letters Bundle', 'Document', 'Bundle of personal letters from 1930s-1950s', '2023-02-28', 'Fair', 'Archive Room - Box 12', 2, 2),
('Railway Station Oil Painting', 'Art', 'Oil on canvas painting of the old railway station', '2021-09-10', 'Excellent', 'Gallery 2 - Wall A', 3, 1),
('Colonial-era Camera', 'Historical Artefact', 'Box camera used by a local photographer, c.1920', '2019-04-01', 'Good', 'Gallery 1 - Case 7', NULL, 2),
('Town Founding Photograph', 'Photograph', 'Original print of the town founding ceremony', '2018-11-11', 'Fair', 'Photo Archive - Folder 4', NULL, 1),
('Beaded Ceremonial Garment', 'Textile', 'Traditional beaded garment used in ceremonies', '2020-06-01', 'Good', 'Gallery 3 - Case 2', NULL, 2);

-- Exhibitions
INSERT INTO Exhibitions (Title, Description, StartDate, EndDate, Venue, ManagedByStaffID) VALUES
('Threads of Time: Textile Exhibition', 'An exploration of traditional textiles and clothing.', '2026-10-15', '2027-01-15', 'Gallery 3', 4),
('Faces of the Founding', 'Photographs and artefacts from the town''s founding era.', '2026-06-01', '2026-09-01', 'Gallery 2', 4),
('Letters Home: A Family History Exhibit', 'Personal letters and documents from local families.', '2026-03-01', '2026-05-30', 'Archive Room', 1);

-- Loans (linking Artefacts to Exhibitions)
INSERT INTO Loans (ArtefactID, ExhibitionID, LoanOutDate, ReturnDate, ConditionOnLoan) VALUES
(6, 1, '2026-10-10', NULL, 'Good'),
(5, 2, '2026-05-25', '2026-09-05', 'Fair'),
(3, 2, '2026-05-25', '2026-09-05', 'Excellent'),
(2, 3, '2026-02-25', '2026-06-02', 'Fair');

-- Bookings
INSERT INTO Bookings (MemberID, StaffID, ExhibitionID, BookingType, BookingDate, NumberOfPeople, Status) VALUES
(1, 3, 2, 'Guided Tour', '2026-06-10', 4, 'Completed'),
(2, 3, NULL, 'Reading Room', '2026-04-02', 1, 'Completed'),
(3, 3, 1, 'Guided Tour', '2026-10-20', 6, 'Confirmed'),
(4, 3, NULL, 'Venue Hire', '2026-11-05', 30, 'Pending'),
(5, 3, 1, 'School Group', '2026-10-22', 25, 'Confirmed');
