<%@page import="java.util.*" %>
<%
  Map<String, ? extends jakarta.servlet.ServletRegistration> regs =
      getServletContext().getServletRegistrations();
  for (Map.Entry<String, ? extends jakarta.servlet.ServletRegistration> e : regs.entrySet()) {
      out.println(e.getKey() + " => " + e.getValue().getMappings() + "<br/>");
  }
%>
