package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Entity
@Table(name = "ZONA_SENSORIAL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ZonaSensorial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_ZONA")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_FILIAL", nullable = false)
    private Filial filial;

    @Column(name = "NOME_ZONA", nullable = false)
    private String nomeZona;

    @Column(name = "TIPO_ZONA")
    private String tipoZona;

    @Column(name = "DESCRICAO")
    private String descricao;

    @Column(name = "RUIDO_MEDIO_ESTIMADO_DB")
    private BigDecimal ruidoMedioEstimadoDb;

    @Column(name = "LUZ_MEDIA_ESTIMADO_LUX")
    private BigDecimal luzMediaEstimadoLux;

    @Column(name = "CARACTERISTICA_VISUAL")
    private String caracteristicaVisual;

    @Column(name = "CAPACIDADE_ESTIMADA")
    private Integer capacidadeEstimada;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;

    @OneToMany(mappedBy = "zonaSensorial", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<EstacaoTrabalho> estacoes;
}
