use salon;

INSERT INTO members (first_name, last_name, contact_number)
VALUES
  ('John', 'Doe', '+1234567890'),
  ('Alice', 'Smith', '+9876543210'),
  ('Bob', 'Johnson', '+5551234567');

INSERT INTO stylists (name, designation)
VALUES
  ('Emma Thompson', 'Senior Stylist'),
  ('David Smith', 'Color Specialist'),
  ('Olivia Davis', 'Haircut Expert'),
  ('Michael Johnson', 'Style Consultant'),
  ('Sophia Lee', 'Master Stylist');

INSERT INTO services (name, cost)
VALUES
  ('Haircut', 2000),
  ('Hair Color', 5000),
  ('Blowout', 3000),
  ('Updo', 4000),
  ('Extensions', 6000);

INSERT INTO rewards (type, name)
VALUES
  ('Hair Gel', 'GlamLocks'),
  ('Curling Iron', 'StyleCraze'),
  ('Dry Shampoo', 'FreshLocks'),
  ('Hair Spray', 'HoldItRight'),
  ('Flat Iron', 'SmoothStyle');

INSERT INTO appointments (member_id, stylist_id, service_id, datetime, venue, points)
VALUES
  (1, 3, 1, "2024/04/31:14:30:00", "salon chair 1", 400);

INSERT INTO transactions (service_id, appointment_id, reward_id)
VALUES
  (1, 1);