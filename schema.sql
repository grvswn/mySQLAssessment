use salon;

create table members (
  member_id int unsigned auto_increment primary key,
  first_name varchar(45) not null,
  last_name varchar(45) not null,
  contact_number varchar(45) not null,
  unique (contact_number)
);

create table stylists (
  stylist_id smallint unsigned auto_increment primary key,
  name VARCHAR (80) NOT NULL,
  designation VARCHAR (30) NOT NULL
);

create table services (
  service_id tinyint unsigned auto_increment primary key,
  name varchar(50) not null,
  cost mediumint unsigned not null
);

create table rewards (
  reward_id smallint unsigned auto_increment primary key,
  name VARCHAR (100) NOT NULL,
  type VARCHAR (50) NOT NULL
);

create table appointments (
  appointment_id int unsigned auto_increment primary key,
  service_id tinyint unsigned not null,
  datetime datetime not null,
  venue varchar(100) not null,
  points mediumint unsigned not null,
  foreign key (member_id) references members(member_id),
  foreign key (stylist_id) references stylists(stylist_id),
  foreign key (service_id) references services(service_id)
);

create table transactions (
  transaction_id int unsigned auto_increment primary key,
  foreign key (appointment_id) references appointments(appointment_id),
  foreign key (service_id) references services(service_id),
  foreign key (reward_id) references rewards(reward_id)
);