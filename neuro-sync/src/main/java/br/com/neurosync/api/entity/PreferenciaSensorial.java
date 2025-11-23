package br.com.neurosync.api.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "PREFERENCIA_SENSORIAL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PreferenciaSensorial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PREFERENCIA")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @Column(name = "RUIDO_MAX_DB")
    private BigDecimal ruidoMaxDb;

    @Column(name = "LUZ_MIN_LUX")
    private BigDecimal luzMinLux;

    @Column(name = "LUZ_MAX_LUX")
    private BigDecimal luzMaxLux;

    @Column(name = "TOLERANCIA_VISUAL")
    private Integer toleranciaVisual;

    @Column(name = "PREFERE_ZONA")
    private String prefereZona;

    @Column(name = "OBSERVACOES_PREFERENCIA")
    private String observacoesPreferencia;

    @Column(name = "DATA_INICIO_VIGENCIA", nullable = false)
    private LocalDate dataInicioVigencia;

    @Column(name = "DATA_FIM_VIGENCIA")
    private LocalDate dataFimVigencia;

    @Column(name = "ATIVO")
    private String ativo;
}
