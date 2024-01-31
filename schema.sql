use salon;

create table members (
  member_id int unsigned auto_increment primary key,
  first_name varchar(45) not null,
  last_name varchar(45) not null,
  contact_number varchar(45) not null,
  unique (contact_number)
) engine = innodb;

create table stylists (
  stylist_id smallint unsigned auto_increment primary key,
  stylist_name varchar(80) not null,
  designation varchar(30) not null
) engine = innodb;

create table services (
  service_id tinyint unsigned auto_increment primary key,
  service_name varchar(50) not null,
  cost mediumint unsigned not null
) engine = innodb;

create table rewards (
  reward_id smallint unsigned auto_increment primary key,
  name varchar(100) not null,
  type varchar(50) not null
) engine = innodb;

create table appointments (
  appointment_id int unsigned auto_increment primary key,
  member_id int unsigned not null,
  stylist_id smallint unsigned not null,
  service_id tinyint unsigned not null,
  datetime datetime not null
) engine = innodb;

alter table appointments add constraint fk_appointments_members 
    foreign key (member_id) references members(member_id);

alter table appointments add constraint fk_appointments_stylists
    foreign key (stylist_id) references stylists(stylist_id);

alter table appointments add constraint fk_appointments_services
    foreign key (service_id) references services(service_id);

create table transactions (
  transaction_id int unsigned auto_increment primary key,
  appointment_id int unsigned not null,
  service_id tinyint unsigned not null,
  reward_id smallint unsigned
) engine = innodb;

alter table appointments add constraint fk_transactions_appointments 
    foreign key (appointment_id) references appointments(appointment_id);

alter table appointments add constraint fk_transactions_services
    foreign key (service_id) references services(service_id);

alter table appointments add constraint fk_transactions_rewards
    foreign key (reward_id) references rewards(reward_id);