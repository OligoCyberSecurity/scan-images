<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
{{- if . }}
  </head>
  <body>
    <h1>{{- escapeXML ( index . 0 ).Target }}</h1>
    <table>
    {{- range . }}
      <tr class="group-header"><th colspan="7">{{ .Type | toString | escapeXML }}</th></tr>
      {{- if (eq (len .Vulnerabilities) 0) }}
      <tr><th colspan="7">No Vulnerabilities found</th></tr>
      {{- else }}
      <tr class="sub-header">
        <th>Package</th>
        <th>Vulnerability ID</th>
        <th>Severity</th>
        <th>Title</th>
        <th>Aqua Vulnerability Database</th>
        <th>Installed Version</th>
        <th>Fixed Version</th>
      </tr>
        {{- range .Vulnerabilities }}
      <tr class="severity-{{ escapeXML .Vulnerability.Severity }}">
        <td class="pkg-name">{{ escapeXML .PkgName }}</td>
        <td>{{ escapeXML .VulnerabilityID }}</td>
        <td class="severity">{{ escapeXML .Vulnerability.Severity }}</td>
        <td>{{ escapeXML .Title }}</td>
        <td class="links">
          <a href={{ escapeXML .PrimaryURL | printf "%q" }}>{{ escapeXML .PrimaryURL }}</a>
        </td>
        <td class="pkg-version">{{ escapeXML .InstalledVersion }}</td>
        <td>{{ escapeXML .FixedVersion }}</td>
      </tr>
        {{- end }}
      {{- end }}
      {{- if (eq (len .Misconfigurations ) 0) }}
      <tr><th colspan="7">No Misconfigurations found</th></tr>
      {{- else }}
      <tr class="sub-header">
        <th>Type</th>
        <th>Misconf ID</th>
        <th>Check</th>
        <th>Severity</th>
        <th>Message</th>
      </tr>
        {{- range .Misconfigurations }}
      <tr class="severity-{{ escapeXML .Severity }}">
        <td class="misconf-type">{{ escapeXML .Type }}</td>
        <td>{{ escapeXML .ID }}</td>
        <td class="misconf-check">{{ escapeXML .Title }}</td>
        <td class="severity">{{ escapeXML .Severity }}</td>
        <td class="link" data-more-links="off"  style="white-space:normal;">
          {{ escapeXML .Message }}
          <br>
            <a href={{ escapeXML .PrimaryURL | printf "%q" }}>{{ escapeXML .PrimaryURL }}</a>
          </br>
        </td>
      </tr>
        {{- end }}
      {{- end }}
    {{- end }}
    </table>
{{- else }}
  </head>
  <body>
    <h1>Trivy Returned Empty Report</h1>
{{- end }}
  </body>
</html>
