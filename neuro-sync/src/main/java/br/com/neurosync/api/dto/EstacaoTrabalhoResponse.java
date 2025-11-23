package br.com.neurosync.api.dto;

import java.time.LocalDateTime;

public class EstacaoTrabalhoResponse {
    private Long id;
    private String codigoEstacao;
    private String descricao;
    private String permiteReserva;
    private String permiteUsoEspontaneo;
    private String statusEstacao;
    private String observacoes;
    private LocalDateTime dataCadastro;
    private Long zonaSensorialId;
    private String zonaSensorialNome;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public LocalDateTime getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(LocalDateTime dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public Long getZonaSensorialId() {
        return zonaSensorialId;
    }

    public void setZonaSensorialId(Long zonaSensorialId) {
        this.zonaSensorialId = zonaSensorialId;
    }

    public String getZonaSensorialNome() {
        return zonaSensorialNome;
    }

    public void setZonaSensorialNome(String zonaSensorialNome) {
        this.zonaSensorialNome = zonaSensorialNome;
    }
}
