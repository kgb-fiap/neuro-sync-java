package br.com.neurosync.api.dto;

public class CompatibilidadeResponse {
    private Long reservaId;
    private boolean compativel;
    private String mensagem;

    public CompatibilidadeResponse(Long reservaId, boolean compativel, String mensagem) {
        this.reservaId = reservaId;
        this.compativel = compativel;
        this.mensagem = mensagem;
    }

    public Long getReservaId() {
        return reservaId;
    }

    public boolean isCompativel() {
        return compativel;
    }

    public String getMensagem() {
        return mensagem;
    }
}
