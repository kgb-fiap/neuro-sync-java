package br.com.neurosync.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "USUARIO")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_USUARIO")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_SETOR", nullable = false)
    private Setor setor;

    @Column(name = "NOME_COMPLETO", nullable = false)
    private String nomeCompleto;

    @Column(name = "EMAIL_CORPORATIVO", nullable = false)
    private String emailCorporativo;

    @Column(name = "MATRICULA_INTERNA")
    private String matriculaInterna;

    @Column(name = "TELEFONE")
    private String telefone;

    @Column(name = "DATA_ADMISSAO")
    private LocalDate dataAdmissao;

    @Column(name = "DATA_CADASTRO")
    private LocalDateTime dataCadastro;

    @Column(name = "STATUS_ATIVO")
    private String statusAtivo;

    @Column(name = "FLAG_NEURODIVERGENTE")
    private String flagNeurodivergente;

    @Column(name = "OBSERVACOES_SUPORTE")
    private String observacoesSuporte;

    @Column(name = "SENHA_HASH", nullable = false)
    private String senhaHash;

    @Column(name = "DATA_ULTIMO_LOGIN")
    private LocalDateTime dataUltimoLogin;

    @Column(name = "QTDE_TENTATIVAS_LOGIN")
    private Integer quantidadeTentativasLogin;

    @Column(name = "MUDAR_SENHA_PROX_LOGIN")
    private String mudarSenhaProximoLogin;

    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<UsuarioPerfil> perfis;

    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<PreferenciaSensorial> preferenciasSensorial;

    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<ReservaEstacao> reservas;
}
