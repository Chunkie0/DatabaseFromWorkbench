drop database if exists music_shop;
create database music_shop;
use music_shop;

create table genres(
    GenreId integer primary key auto_increment not null,
    Name nvarchar(120)
);

create table playlists(
    PlaylistId integer primary key auto_increment not null,
    Name nvarchar(120)
);

create table artists(
    ArtistId integer primary key auto_increment not null,
    Name nvarchar(120)
);

create table albums(
    AlbumId integer primary key auto_increment not null,
    Title nvarchar(160)  not null,
    ArtistId integer  not null,
    foreign key (ArtistId) references artists (ArtistId) 
        on delete no action on update no action
);


create table media_types(
    MediaTypeId integer primary key auto_increment not null,
    Name nvarchar(120)
);

create table tracks(
	TrackId integer primary key auto_increment not null,
    Name nvarchar(200),
    AlbumId integer,
    MediaTypeId integer not null,
    GenreId integer,
    Composer nvarchar(220),
    Milliseconds integer not null,
    Bytes integer,
    UnitPrice numeric(10,2) not null,
    foreign key (AlbumId) references albums (AlbumId)
		on delete no action on update no action,
	foreign key (GenreId) references genres (GenreId)
        on delete no action on update no action,
	foreign key (MediaTypeId) references media_types (MediaTypeId)
        on delete no action on update no action
);

create index IFK_TrackAlbumId on tracks (AlbumId);
create index IFK_TrackGenreId on tracks (GenreId);
create index IFK_TrackMediaTypeId on tracks (MediaTypeId);

create table employees(
	EmployeeId integer primary key auto_increment not null,
    LastName nvarchar(20) not null,
    FirstName nvarchar(20) not null,
    Title nvarchar(30),
    ReportsTo integer,
    BirthDate datetime,
    HireDate datetime,
    Address nvarchar(70),
    City nvarchar(40),
    State nvarchar(40),
    Country nvarchar(40),
    PostalCode nvarchar(10),
    Phone nvarchar(24),
    Fax nvarchar(24),
    Email nvarchar(60),
    foreign key (ReportsTo) references employees (EmployeeId)
        on delete no action on update no action
);

create index IFK_EmployeeReportsTo on employees (ReportsTo);

create table users(
	UserId integer primary key auto_increment not null,
    EmployeeId integer null,
    User_name nvarchar(20) not null,
    User_password nvarchar(64),
    `User` boolean null,
    `Manager` boolean null,
    `Admin` boolean null,
	foreign key (EmployeeId) references employees (EmployeeId)
		on delete no action on update no action
);

create index IFK_UserEmployeeId on employees (EmployeeId);

create table customers(
	CustomerId integer primary key auto_increment not null,
    FirstName nvarchar(40) not null,
    LastName nvarchar(20) not null,
    Company nvarchar(80),
    Address nvarchar(70),
    City nvarchar(40),
    State nvarchar(40),
    Country nvarchar(40),
    PostalCode nvarchar(10),
    Phone nvarchar(24),
    Fax nvarchar(24),
    Email nvarchar(60) not null,
    SupportRepId integer,
	foreign key (SupportRepId) references employees (EmployeeId)
        on delete no action on update no action
);

create index IFK_CustomerSupportRepId on customers (SupportRepId);

create table invoices(
	InvoiceId integer primary key auto_increment not null,
    CustomerId integer not null,
    InvoiceDate datetime not null,
    BillingAddress nvarchar(70),
    BillingCity nvarchar(40),
    BillingState nvarchar(40),
    BillingCountry nvarchar(40),
    BillingPostalCode nvarchar(10),
    Total numeric(10, 2) not null,
    foreign key (CustomerId) references customers (CustomerId)
		on delete no action on update no action
);

create index IFK_InvoiceCustomerId on invoices (CustomerId);

create table invoice_items(
	InvoiceLineId integer primary key auto_increment not null,
    InvoiceId integer not null,
    TrackId integer not null,
    UnitPrice numeric(10,2) not null,
    Quantity integer not null,
	foreign key (InvoiceId) references invoices (InvoiceId)
		on delete no action on update no action,
	foreign key (TrackId) references tracks (TrackId)
		on delete no action on update no action
);

create index IFK_InvoiceLineInvoiceId on invoice_items (InvoiceId);
create index IFK_InvoiceLineTrackId on invoice_items (TrackId);

create table playlist_track(
	PlayListId integer not null,
    TrackId integer not null,
    constraint PK_PlaylistTracak primary key (PlaylistId, TrackId),
	foreign key (PlaylistId) references playlists (PlaylistId)
		on delete no action on update no action,
	foreign key (TrackId) references tracks (TrackId)
		on delete no action on update no action
);

create index IFK_PlaylistTrackTrackId ON playlist_track (TrackId);