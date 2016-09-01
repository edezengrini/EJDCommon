package common.base;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class FlagBase implements Serializable {

	private static final long serialVersionUID = 1L;

	public static final Long PRODUTO_IDFLAGSTATUS_ATIVO = new Long(1);
	public static final Long PRODUTO_IDFLAGSTATUS_BAIXADO = new Long(2);

    public static final Long PESSOA_IDFLAGSTATUS_ATIVO = new Long(3);
    public static final Long PESSOA_IDFLAGSTATUS_INATIVO = new Long(4);
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getListOfFlagBean() {
		List list = new ArrayList();

		list.add(new FlagBean(1, "Ativo", "PRODUTO", "IDFLAGTIPOPRODUTO"));
		list.add(new FlagBean(2, "Baixado", "PRODUTO", "IDFLAGTIPOPRODUTO"));

        list.add(new FlagBean(3, "Ativo", "PESSOA", "IDFLAGPESSOAATIVA"));
        list.add(new FlagBean(4, "Inativo", "PESSOA", "IDFLAGPESSOAINATIVA"));
		
		return list;
	}
}
