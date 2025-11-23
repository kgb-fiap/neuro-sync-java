package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "RESERVA_ESTACAO")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReservaEstacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_RESERVA")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_ESTACAO", nullable = false)
    private EstacaoTrabalho estacaoTrabalho;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_STATUS_RESERVA", nullable = false)
    private StatusReserva statusReserva;

    @Column(name = "DATA_HORA_SOLICITACAO")
    private LocalDateTime dataHoraSolicitacao;

    @Column(name = "DATA_HORA_INICIO_PREVISTA")
    private LocalDateTime dataHoraInicioPrevista;

    @Column(name = "DATA_HORA_FIM_PREVISTA")
    private LocalDateTime dataHoraFimPrevista;

    @Column(name = "DATA_HORA_CHECKIN")
    private LocalDateTime dataHoraCheckin;

    @Column(name = "DATA_HORA_CHECKOUT")
    private LocalDateTime dataHoraCheckout;

    @Column(name = "ORIGEM_RESERVA")
    private String origemReserva;

    @Column(name = "MOTIVO_CANCELAMENTO")
    private String motivoCancelamento;

    @Column(name = "INDICE_CONFORTO_CALCULADO")
    private BigDecimal indiceConfortoCalculado;

    @Column(name = "OBSERVACOES")
    private String observacoes;

    @OneToOne(mappedBy = "reservaEstacao", fetch = FetchType.LAZY)
    @JsonIgnore
    private AvaliacaoEstacao avaliacaoEstacao;
}
