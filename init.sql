-- auto-generated definition
create table inquiries
(
    inquiry_id       bigint auto_increment
        primary key,
    writer_id        bigint                                 not null,
    talent_id        bigint                                 not null,
    talent_owner_id  bigint                                 null,
    content          text                                   not null,
    response_content text                                   null,
    status           enum ('pending', 'answered', 'closed') not null,
    created_at       timestamp default current_timestamp()  null,
    constraint inquiries_ibfk_1
        foreign key (writer_id) references members (mno)
            on delete cascade,
    constraint inquiries_ibfk_2
        foreign key (talent_id) references talents (tno)
            on delete cascade,
    constraint inquiries_ibfk_3
        foreign key (talent_owner_id) references members (mno)
            on delete set null
);

create index talent_id
    on inquiries (talent_id);

create index talent_owner_id
    on inquiries (talent_owner_id);

create index writer_id
    on inquiries (writer_id);


-- auto-generated definition
create table talents
(
    tno           bigint auto_increment
        primary key,
    member_id     bigint                               not null,
    title         varchar(255)                         not null,
    description   text                                 null,
    price         decimal(15, 2)                       not null,
    category      varchar(50)                          not null,
    rating        decimal(3, 2)                        null,
    creation_date datetime default current_timestamp() null,
    image         varchar(255)                         null,
    constraint talents_ibfk_1
        foreign key (member_id) references members (mno)
            on delete cascade
);

create index member_id
    on talents (member_id);



-- auto-generated definition
create table transactions
(
    transaction_id   bigint auto_increment
        primary key,
    buyer_id         bigint                               not null,
    talent_id        bigint                               not null,
    amount           decimal(15, 2)                       not null,
    transaction_date datetime default current_timestamp() null,
    scheduled_date   datetime                             null,
    time_slot        varchar(20)                          null,
    remarks          text                                 null,
    talent_owner_id  bigint                               null,
    constraint transactions_ibfk_1
        foreign key (buyer_id) references members (mno)
            on delete cascade,
    constraint transactions_ibfk_2
        foreign key (talent_id) references talents (tno)
            on delete cascade,
    constraint transactions_ibfk_3
        foreign key (talent_owner_id) references members (mno)
            on delete set null
);

create index buyer_id
    on transactions (buyer_id);

create index talent_id
    on transactions (talent_id);


-- auto-generated definition
create table reviews
(
    review_id      bigint auto_increment
        primary key,
    transaction_id bigint                                not null,
    talent_id      bigint                                not null,
    member_id      bigint                                not null,
    rating         decimal(3, 2)                         not null,
    created_at     timestamp default current_timestamp() null,
    updated_at     timestamp default current_timestamp() null on update current_timestamp(),
    constraint reviews_ibfk_1
        foreign key (transaction_id) references transactions (transaction_id)
            on delete cascade,
    constraint reviews_ibfk_2
        foreign key (talent_id) references talents (tno)
            on delete cascade,
    constraint reviews_ibfk_3
        foreign key (member_id) references members (mno)
            on delete cascade
);

create index member_id
    on reviews (member_id);

create index talent_id
    on reviews (talent_id);

create index transaction_id
    on reviews (transaction_id);


-- auto-generated definition
create table talent_time_slot
(
    sno            bigint auto_increment
        primary key,
    talent_id      bigint                                                                            not null,
    time_slot      tinyint                                                                           not null,
    status         enum ('AVAILABLE', 'BLOCKED', 'PENDING', 'CONFIRMED') default 'AVAILABLE'         null,
    scheduled_date datetime                                                                          not null,
    created_at     timestamp                                             default current_timestamp() null,
    updated_at     timestamp                                             default current_timestamp() null on update current_timestamp(),
    constraint talent_time_slot_ibfk_1
        foreign key (talent_id) references talents (tno)
);

create index talent_id
    on talent_time_slot (talent_id);


-- auto-generated definition
create table login_tokens
(
    token_id        bigint auto_increment
        primary key,
    user_id         bigint                                not null,
    token           varchar(255)                          not null,
    expiration_date datetime                              not null,
    created_at      timestamp default current_timestamp() null,
    updated_at      timestamp default current_timestamp() null on update current_timestamp(),
    constraint login_tokens_ibfk_1
        foreign key (user_id) references members (mno)
            on delete cascade
);

create index user_id
    on login_tokens (user_id);


-- auto-generated definition
create table members
(
    mno      bigint auto_increment
        primary key,
    id       varchar(50)  not null,
    name     varchar(100) not null,
    password varchar(255) not null,
    fileName varchar(255) null,
    constraint id
        unique (id)
);


-- auto-generated definition
create table account_info
(
    account_id     bigint auto_increment
        primary key,
    member_id      bigint                                not null,
    bank_name      varchar(50)                           not null,
    account_number varchar(20)                           not null,
    account_holder varchar(100)                          not null,
    created_at     timestamp default current_timestamp() null,
    updated_at     timestamp default current_timestamp() null on update current_timestamp(),
    constraint account_info_ibfk_1
        foreign key (member_id) references members (mno)
);

create index member_id
    on account_info (member_id);


