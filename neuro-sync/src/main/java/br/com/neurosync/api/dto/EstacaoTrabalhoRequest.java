package br.com.neurosync.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class EstacaoTrabalhoRequest {

    @NotNull
    private Long zonaSensorialId;

    @NotBlank
    private String codigoEstacao;

    private String descricao;
    private String permiteReserva;
    private String permiteUsoEspontaneo;
    private String statusEstacao;
    private String observacoes;

    public Long getZonaSensorialId() {
        return zonaSensorialId;
    }

    public void setZonaSensorialId(Long zonaSensorialId) {
        this.zonaSensorialId = zonaSensorialId;
    }

    public String getCodigoEstacao() {
        return codigoEstacao;
    }

    public void setCodigoEstacao(String codigoEstacao) {
        this.codigoEstacao = codigoEstacao;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getPermiteReserva() {
        return permiteReserva;
    }

    public void setPermiteReserva(String permiteReserva) {
        this.permiteReserva = permiteReserva;
    }

    public String getPermiteUsoEspontaneo() {
        return permiteUsoEspontaneo;
    }

    public void setPermiteUsoEspontaneo(String permiteUsoEspontaneo) {
        this.permiteUsoEspontaneo = permiteUsoEspontaneo;
    }

    public String getStatusEstacao() {
        return statusEstacao;
    }

    public void setStatusEstacao(String statusEstacao) {
        this.statusEstacao = statusEstacao;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
}
