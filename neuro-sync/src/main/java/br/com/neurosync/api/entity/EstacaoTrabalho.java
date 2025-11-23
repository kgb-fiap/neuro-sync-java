package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "ESTACAO_TRABALHO")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EstacaoTrabalho {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_ESTACAO")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_ZONA", nullable = false)
    private ZonaSensorial zonaSensorial;

    @Column(name = "CODIGO_ESTACAO", nullable = false)
    private String codigoEstacao;

    @Column(name = "DESCRICAO")
    private String descricao;

    @Column(name = "PERMITE_RESERVA")
    private String permiteReserva;

    @Column(name = "PERMITE_USO_ESPONTANEO")
    private String permiteUsoEspontaneo;

    @Column(name = "STATUS_ESTACAO")
    private String statusEstacao;

    @Column(name = "OBSERVACOES")
    private String observacoes;

    @Column(name = "DATA_CADASTRO")
    private LocalDateTime dataCadastro;

    @OneToMany(mappedBy = "estacaoTrabalho", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Sensor> sensores;

    @OneToMany(mappedBy = "estacaoTrabalho", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<ReservaEstacao> reservas;
}
