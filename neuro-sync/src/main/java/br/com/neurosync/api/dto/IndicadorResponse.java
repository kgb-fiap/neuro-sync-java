package br.com.neurosync.api.dto;

import java.math.BigDecimal;

public class IndicadorResponse {
    private String indicador;
    private BigDecimal valor;

    public IndicadorResponse(String indicador, BigDecimal valor) {
        this.indicador = indicador;
        this.valor = valor;
    }

    public String getIndicador() {
        return indicador;
    }

    public BigDecimal getValor() {
        return valor;
    }
}
