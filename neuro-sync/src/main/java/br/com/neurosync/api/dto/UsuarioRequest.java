package br.com.neurosync.api.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;
import java.util.List;

public class UsuarioRequest {

    @NotNull
    private Long setorId;

    @NotBlank
    @Size(max = 150)
    private String nomeCompleto;

    @Email
    @NotBlank
    private String emailCorporativo;

    @NotBlank
    private String senha;

    private String matriculaInterna;
    private String telefone;
    private LocalDate dataAdmissao;
    private String flagNeurodivergente;
    private List<Long> perfisIds;

    public Long getSetorId() {
        return setorId;
    }

    public void setSetorId(Long setorId) {
        this.setorId = setorId;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }

    public String getEmailCorporativo() {
        return emailCorporativo;
    }

    public void setEmailCorporativo(String emailCorporativo) {
        this.emailCorporativo = emailCorporativo;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getMatriculaInterna() {
        return matriculaInterna;
    }

    public void setMatriculaInterna(String matriculaInterna) {
        this.matriculaInterna = matriculaInterna;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public LocalDate getDataAdmissao() {
        return dataAdmissao;
    }

    public void setDataAdmissao(LocalDate dataAdmissao) {
        this.dataAdmissao = dataAdmissao;
    }

    public String getFlagNeurodivergente() {
        return flagNeurodivergente;
    }

    public void setFlagNeurodivergente(String flagNeurodivergente) {
        this.flagNeurodivergente = flagNeurodivergente;
    }

    public List<Long> getPerfisIds() {
        return perfisIds;
    }

    public void setPerfisIds(List<Long> perfisIds) {
        this.perfisIds = perfisIds;
    }
}
