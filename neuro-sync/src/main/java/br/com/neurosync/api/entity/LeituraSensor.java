package br.com.neurosync.api.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "LEITURA_SENSOR")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LeituraSensor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_LEITURA")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_SENSOR", nullable = false)
    private Sensor sensor;

    @Column(name = "DATA_HORA_LEITURA", nullable = false)
    private LocalDateTime dataHoraLeitura;

    @Column(name = "VALOR_MEDIDO", nullable = false)
    private BigDecimal valorMedido;

    @Column(name = "QUALIDADE_SINAL")
    private Integer qualidadeSinal;

    @Column(name = "ORIGEM_REGISTRO")
    private String origemRegistro;

    @Column(name = "DATA_PROCESSAMENTO")
    private LocalDateTime dataProcessamento;
}
