package br.com.neurosync.api.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ReservaResponse {
    private Long id;
    private Long usuarioId;
    private String usuarioNome;
    private Long estacaoId;
    private String codigoEstacao;
    private Long statusReservaId;
    private String statusCodigo;
    private LocalDateTime dataHoraSolicitacao;
    private LocalDateTime dataHoraInicioPrevista;
    private LocalDateTime dataHoraFimPrevista;
    private LocalDateTime dataHoraCheckin;
    private LocalDateTime dataHoraCheckout;
    private String origemReserva;
    private String motivoCancelamento;
    private BigDecimal indiceConfortoCalculado;
    private String observacoes;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getUsuarioNome() {
        return usuarioNome;
    }

    public void setUsuarioNome(String usuarioNome) {
        this.usuarioNome = usuarioNome;
    }

    public Long getEstacaoId() {
        return estacaoId;
    }

    public void setEstacaoId(Long estacaoId) {
        this.estacaoId = estacaoId;
    }

    public String getCodigoEstacao() {
        return codigoEstacao;
    }

    public void setCodigoEstacao(String codigoEstacao) {
        this.codigoEstacao = codigoEstacao;
    }

    public Long getStatusReservaId() {
        return statusReservaId;
    }

    public void setStatusReservaId(Long statusReservaId) {
        this.statusReservaId = statusReservaId;
    }

    public String getStatusCodigo() {
        return statusCodigo;
    }

    public void setStatusCodigo(String statusCodigo) {
        this.statusCodigo = statusCodigo;
    }

    public LocalDateTime getDataHoraSolicitacao() {
        return dataHoraSolicitacao;
    }

    public void setDataHoraSolicitacao(LocalDateTime dataHoraSolicitacao) {
        this.dataHoraSolicitacao = dataHoraSolicitacao;
    }

    public LocalDateTime getDataHoraInicioPrevista() {
        return dataHoraInicioPrevista;
    }

    public void setDataHoraInicioPrevista(LocalDateTime dataHoraInicioPrevista) {
        this.dataHoraInicioPrevista = dataHoraInicioPrevista;
    }

    public LocalDateTime getDataHoraFimPrevista() {
        return dataHoraFimPrevista;
    }

    public void setDataHoraFimPrevista(LocalDateTime dataHoraFimPrevista) {
        this.dataHoraFimPrevista = dataHoraFimPrevista;
    }

    public LocalDateTime getDataHoraCheckin() {
        return dataHoraCheckin;
    }

    public void setDataHoraCheckin(LocalDateTime dataHoraCheckin) {
        this.dataHoraCheckin = dataHoraCheckin;
    }

    public LocalDateTime getDataHoraCheckout() {
        return dataHoraCheckout;
    }

    public void setDataHoraCheckout(LocalDateTime dataHoraCheckout) {
        this.dataHoraCheckout = dataHoraCheckout;
    }

    public String getOrigemReserva() {
        return origemReserva;
    }

    public void setOrigemReserva(String origemReserva) {
        this.origemReserva = origemReserva;
    }

    public String getMotivoCancelamento() {
        return motivoCancelamento;
    }

    public void setMotivoCancelamento(String motivoCancelamento) {
        this.motivoCancelamento = motivoCancelamento;
    }

    public BigDecimal getIndiceConfortoCalculado() {
        return indiceConfortoCalculado;
    }

    public void setIndiceConfortoCalculado(BigDecimal indiceConfortoCalculado) {
        this.indiceConfortoCalculado = indiceConfortoCalculado;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
}
