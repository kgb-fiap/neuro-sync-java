package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "TIPO_SENSOR")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TipoSensor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_TIPO_SENSOR")
    private Long id;

    @Column(name = "NOME_TIPO_SENSOR", nullable = false)
    private String nomeTipoSensor;

    @Column(name = "UNIDADE_MEDIDA")
    private String unidadeMedida;

    @Column(name = "DESCRICAO")
    private String descricao;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;

    @OneToMany(mappedBy = "tipoSensor", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Sensor> sensores;
}
