package uz.fido.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bank {
    private Integer id;
    private String name;
    private String address;
    private String iban;
}
