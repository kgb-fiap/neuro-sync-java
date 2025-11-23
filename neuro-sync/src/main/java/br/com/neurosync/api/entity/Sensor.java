package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "SENSOR")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Sensor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_SENSOR")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_ESTACAO", nullable = false)
    private EstacaoTrabalho estacaoTrabalho;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_TIPO_SENSOR", nullable = false)
    private TipoSensor tipoSensor;

    @Column(name = "IDENTIFICADOR_HARDWARE", nullable = false)
    private String identificadorHardware;

    @Column(name = "DATA_INSTALACAO")
    private LocalDate dataInstalacao;

    @Column(name = "DATA_ULTIMA_MANUTENCAO")
    private LocalDate dataUltimaManutencao;

    @Column(name = "STATUS_SENSOR")
    private String statusSensor;

    @Column(name = "OBSERVACOES")
    private String observacoes;

    @OneToMany(mappedBy = "sensor", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<LeituraSensor> leituras;
}
