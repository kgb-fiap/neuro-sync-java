package br.com.neurosync.api.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public class AvaliacaoRequest {

    @NotNull
    private Long reservaId;

    @NotNull
    @Min(1)
    @Max(5)
    private Integer notaConfortoGeral;

    @Min(1)
    @Max(5)
    private Integer notaRuido;

    @Min(1)
    @Max(5)
    private Integer notaLuz;

    @Min(1)
    @Max(5)
    private Integer notaEstimuloVisual;

    private String comentario;

    public Long getReservaId() {
        return reservaId;
    }

    public void setReservaId(Long reservaId) {
        this.reservaId = reservaId;
    }

    public Integer getNotaConfortoGeral() {
        return notaConfortoGeral;
    }

    public void setNotaConfortoGeral(Integer notaConfortoGeral) {
        this.notaConfortoGeral = notaConfortoGeral;
    }

    public Integer getNotaRuido() {
        return notaRuido;
    }

    public void setNotaRuido(Integer notaRuido) {
        this.notaRuido = notaRuido;
    }

    public Integer getNotaLuz() {
        return notaLuz;
    }

    public void setNotaLuz(Integer notaLuz) {
        this.notaLuz = notaLuz;
    }

    public Integer getNotaEstimuloVisual() {
        return notaEstimuloVisual;
    }

    public void setNotaEstimuloVisual(Integer notaEstimuloVisual) {
        this.notaEstimuloVisual = notaEstimuloVisual;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }
}
