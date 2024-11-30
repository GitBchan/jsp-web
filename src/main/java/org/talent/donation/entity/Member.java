package org.talent.donation.entity;

import lombok.*;

import java.io.Serializable;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member implements Serializable {
    private Long mno;
    private String id;
    private String name;
    private String password;
    private String fileName;
}
