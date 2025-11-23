package br.com.neurosync.api.dto;

import java.time.LocalDateTime;

public class AvaliacaoResponse {
    private Long id;
    private Long reservaId;
    private Integer notaConfortoGeral;
    private Integer notaRuido;
    private Integer notaLuz;
    private Integer notaEstimuloVisual;
    private String comentario;
    private LocalDateTime dataAvaliacao;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public LocalDateTime getDataAvaliacao() {
        return dataAvaliacao;
    }

    public void setDataAvaliacao(LocalDateTime dataAvaliacao) {
        this.dataAvaliacao = dataAvaliacao;
    }
}
