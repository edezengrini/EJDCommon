package common.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Map.Entry;
import java.util.Set;

public final class UtilCommon {
	public static final SimpleDateFormat FORMAT_DATE_HOUR = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	public static final SimpleDateFormat FORMAT_DATE = new SimpleDateFormat("dd/MM/yyyy");
	public static final SimpleDateFormat FORMT_HOUR = new SimpleDateFormat("HH:mm:ss");
	public static final DecimalFormat FORMAT_DECIMAL = new DecimalFormat("#,##0.00");
	public static final DecimalFormat FORMAT_DECIMAL_SOMENTE_PONTO = new DecimalFormat("##0.00");
	public static final DecimalFormat FORMAT_DECIMAL_SOMENTE_PONTO_QUATRO_DECIMAIS = new DecimalFormat("##0.0000");

	public static String formatDecimal(BigDecimal bigDecimal) {
		if (bigDecimal == null)
			return null;

		return FORMAT_DECIMAL.format(bigDecimal.doubleValue());

	}

	public static String formatDecimalSomentePonto(BigDecimal bigDecimal) {
		if (bigDecimal == null)
			return null;

		return FORMAT_DECIMAL_SOMENTE_PONTO.format(bigDecimal.doubleValue());

	}

    public static String formatDecimalSomentePontoQuatroDecimais(BigDecimal bigDecimal) {
        if (bigDecimal == null)
            return null;

        return FORMAT_DECIMAL_SOMENTE_PONTO_QUATRO_DECIMAIS.format(bigDecimal.doubleValue());

    }

	public static Double convertDecimal(String valor) throws RuntimeException {
		if (valor == null || valor.trim().isEmpty())
			return null;
		try {
			return FORMAT_DECIMAL.parse(valor).doubleValue();
		} catch (ParseException e) {
			throw new RuntimeException(MessageFormat.format("Formato do número({0}) inválido!", valor));
		}

	}

	public static BigDecimal convertBigDecimal(String valor) throws RuntimeException {
		if (valor == null || valor.trim().isEmpty())
			return null;
		try {
			return new BigDecimal(FORMAT_DECIMAL.parse(valor).doubleValue());
		} catch (ParseException e) {
			throw new RuntimeException(MessageFormat.format("Formato do número({0}) inválido!", valor));
		}

	}

	public static BigDecimal convertBigDecimalSomentePonto(String valor) throws RuntimeException {
		if (valor == null || valor.trim().isEmpty())
			return null;
		try {
			return new BigDecimal(FORMAT_DECIMAL_SOMENTE_PONTO.parse(valor).doubleValue());
		} catch (ParseException e) {
			throw new RuntimeException(MessageFormat.format("Formato do número({0}) inválido!", valor));
		}

	}

	public static Integer convertInteiro(String valor) throws RuntimeException {
		if (valor == null || valor.trim().isEmpty())
			return null;
		try {
			return Integer.parseInt(valor);
		} catch (NumberFormatException e) {
			throw new RuntimeException(MessageFormat.format("Formato do número({0}) inválido!", valor));
		}

	}

	public static String formatDecimal(Double valor) {
		if (valor == null)
			return null;
		return FORMAT_DECIMAL.format(valor);
	}

	public static String formatDate(Date date) {
		if (date == null)
			return null;
		return FORMAT_DATE.format(date);
	}

	public static String formatHour(Date date) {
		if (date == null)
			return null;
		return FORMT_HOUR.format(date);
	}

	public static String formatDateHour(Date date) {
		if (date == null)
			return null;
		return FORMAT_DATE_HOUR.format(date);
	}

	public static Integer hourToMinute(String time) throws Exception {
		try {
			if (!validateHour(time)) {
				throw new RuntimeException("Formato da hora (" + time + ") inválida");
			}
			String[] str = time.split(":");

			return (Integer.parseInt(str[0]) * 60) + Integer.parseInt(str[1]);

		} catch (Exception e) {
			throw new RuntimeException("Não foi possível converter a hora (" + time + ")\npara seu valor correspondente em minutos.", e);
		}
	}

	public static Integer hourToSecond(String time) throws Exception {
		try {
			if (!validateHour(time)) {
				throw new RuntimeException("Formato da hora (" + time + ") inválida");
			}
			String[] str = time.split(":");

			return (Integer.parseInt(str[0]) * 3600) + (Integer.parseInt(str[1]) * 60) + Integer.parseInt(str[2]);

		} catch (Exception e) {
			throw new RuntimeException("Não foi possível converter a hora (" + time + ")\npara seu valor correspondente em minutos.", e);
		}
	}

	public static String roundMinute(String time) throws Exception {
		try {
			if (!validateHour(time)) {
				throw new RuntimeException("Formato da hora (" + time + ") inválida");
			}
			String[] str = time.split(":");

			String strHour = str[0];
			String strMinute = str[1];
			String strSecond = str[2];

			int intHour = Integer.parseInt(strHour);
			int intMinute = Integer.parseInt(strMinute);
			int intSecond = Integer.parseInt(strSecond);

			if (intSecond > 0) {
				intMinute++;
				Calendar calendar = new GregorianCalendar();

				calendar.set(Calendar.HOUR_OF_DAY, intHour);
				calendar.set(Calendar.MINUTE, intMinute);
				calendar.set(Calendar.SECOND, 0);

				return FORMT_HOUR.format(calendar.getTime());
			} else {
				return time;
			}
		} catch (Exception e) {
			throw new RuntimeException("Não foi possível arredondar os minutos da hora (" + time + ").", e);
		}
	}

	public static boolean validateHour(String time) {
		try {
			if (time == null || time.length() != 8) {
				return false;
			}
			String[] str = time.split(":");

			if (str.length != 3)
				return false;

			String strHour = str[0];
			String strMinute = str[1];
			String strSecond = str[2];

			int hour = Integer.parseInt(strHour);
			if (hour > 23 || hour < 0) {
				return false;
			}
			int minute = Integer.parseInt(strMinute);
			if (minute > 59 || minute < 0) {
				return false;
			}
			int second = Integer.parseInt(strSecond);
			if (second > 59 || second < 0) {
				return false;
			}

			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public static String toStringNotNull(Object valor) {
		return valor != null ? valor.toString() : null;
	}

	public static void saveFile(File file, String contents) throws IOException {
		Writer writer = new FileWriter(file);
		writer.write(contents);
		writer.flush();
		writer.close();
	}

	public static void printSystemProperties() {

		Set<Entry<Object, Object>> properties = System.getProperties().entrySet();

		for (Entry<Object, Object> entry : properties) {
			System.out.println(entry.getKey() + ": " + entry.getValue());
		}
	}

}
