package br.com.neurosync.api.dto;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

public class ReservaRequest {

    @NotNull
    private Long usuarioId;

    @NotNull
    private Long estacaoId;

    @NotNull
    private Long statusReservaId;

    @NotNull
    @FutureOrPresent
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime dataHoraInicioPrevista;

    @NotNull
    @FutureOrPresent
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime dataHoraFimPrevista;

    private String origemReserva;
    private String observacoes;

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    public Long getEstacaoId() {
        return estacaoId;
    }

    public void setEstacaoId(Long estacaoId) {
        this.estacaoId = estacaoId;
    }

    public Long getStatusReservaId() {
        return statusReservaId;
    }

    public void setStatusReservaId(Long statusReservaId) {
        this.statusReservaId = statusReservaId;
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

    public String getOrigemReserva() {
        return origemReserva;
    }

    public void setOrigemReserva(String origemReserva) {
        this.origemReserva = origemReserva;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
}
