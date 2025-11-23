package br.com.neurosync.api.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class PreferenciaSensorialResponse {
    private Long id;
    private Long usuarioId;
    private BigDecimal ruidoMaxDb;
    private BigDecimal luzMinLux;
    private BigDecimal luzMaxLux;
    private Integer toleranciaVisual;
    private String prefereZona;
    private String observacoesPreferencia;
    private LocalDate dataInicioVigencia;
    private LocalDate dataFimVigencia;
    private String ativo;

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

    public BigDecimal getRuidoMaxDb() {
        return ruidoMaxDb;
    }

    public void setRuidoMaxDb(BigDecimal ruidoMaxDb) {
        this.ruidoMaxDb = ruidoMaxDb;
    }

    public BigDecimal getLuzMinLux() {
        return luzMinLux;
    }

    public void setLuzMinLux(BigDecimal luzMinLux) {
        this.luzMinLux = luzMinLux;
    }

    public BigDecimal getLuzMaxLux() {
        return luzMaxLux;
    }

    public void setLuzMaxLux(BigDecimal luzMaxLux) {
        this.luzMaxLux = luzMaxLux;
    }

    public Integer getToleranciaVisual() {
        return toleranciaVisual;
    }

    public void setToleranciaVisual(Integer toleranciaVisual) {
        this.toleranciaVisual = toleranciaVisual;
    }

    public String getPrefereZona() {
        return prefereZona;
    }

    public void setPrefereZona(String prefereZona) {
        this.prefereZona = prefereZona;
    }

    public String getObservacoesPreferencia() {
        return observacoesPreferencia;
    }

    public void setObservacoesPreferencia(String observacoesPreferencia) {
        this.observacoesPreferencia = observacoesPreferencia;
    }

    public LocalDate getDataInicioVigencia() {
        return dataInicioVigencia;
    }

    public void setDataInicioVigencia(LocalDate dataInicioVigencia) {
        this.dataInicioVigencia = dataInicioVigencia;
    }

    public LocalDate getDataFimVigencia() {
        return dataFimVigencia;
    }

    public void setDataFimVigencia(LocalDate dataFimVigencia) {
        this.dataFimVigencia = dataFimVigencia;
    }

    public String getAtivo() {
        return ativo;
    }

    public void setAtivo(String ativo) {
        this.ativo = ativo;
    }
}
