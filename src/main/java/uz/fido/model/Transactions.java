package uz.fido.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.fido.enums.TransactionType;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Transactions {
    private int id;
    private TransactionType type;
    private Double amount;
    private Date date;
    private Integer from_id;
    private Integer to_id;
}
