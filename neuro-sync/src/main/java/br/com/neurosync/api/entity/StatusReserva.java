package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "STATUS_RESERVA")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StatusReserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_STATUS_RESERVA")
    private Long id;

    @Column(name = "CODIGO_STATUS", nullable = false)
    private String codigoStatus;

    @Column(name = "DESCRICAO")
    private String descricao;

    @Column(name = "E_FINALIZADOR")
    private String finalizador;

    @OneToMany(mappedBy = "statusReserva", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<ReservaEstacao> reservas;
}
