package br.com.neurosync.api.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "AVALIACAO_ESTACAO")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AvaliacaoEstacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_AVALIACAO")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_RESERVA", nullable = false)
    private ReservaEstacao reservaEstacao;

    @Column(name = "NOTA_CONFORTO_GERAL", nullable = false)
    private Integer notaConfortoGeral;

    @Column(name = "NOTA_RUIDO")
    private Integer notaRuido;

    @Column(name = "NOTA_LUZ")
    private Integer notaLuz;

    @Column(name = "NOTA_ESTIMULO_VISUAL")
    private Integer notaEstimuloVisual;

    @Column(name = "COMENTARIO")
    private String comentario;

    @Column(name = "DATA_AVALIACAO")
    private LocalDateTime dataAvaliacao;
}
