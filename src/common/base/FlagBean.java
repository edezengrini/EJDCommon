package common.base;

import java.io.Serializable;
import java.math.BigDecimal;

public class FlagBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long idFlag;
	private String descricao;
	private String nomeEntidade;
	private String nomeAtributo;

	public FlagBean(int idFlag, String descricao, String nomeEntidade, String nomeAtributo) {
		this.idFlag = new Long(idFlag);
		this.descricao = descricao;
		this.nomeEntidade = nomeEntidade;
		this.nomeAtributo = nomeAtributo;
	}

	public FlagBean(BigDecimal idFlag, String descricao, String nomeEntidade, String nomeAtributo) {
		this.idFlag = new Long(idFlag.longValue());
		this.descricao = descricao;
		this.nomeEntidade = nomeEntidade;
		this.nomeAtributo = nomeAtributo;
	}

	public FlagBean(Long idFlag, String descricao, String nomeEntidade, String nomeAtributo) {
		this.idFlag = idFlag;
		this.descricao = descricao;
		this.nomeEntidade = nomeEntidade;
		this.nomeAtributo = nomeAtributo;
	}

	public Long getIdFlag() {
		return this.idFlag;
	}

	public String getDescricao() {
		return this.descricao;
	}

	public String getNomeEntidade() {
		return this.nomeEntidade;
	}

	public String getNomeAtributo() {
		return this.nomeAtributo;
	}
}