<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" indent="yes"/>
    
    <!-- Define CSS styles -->
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title><xsl:value-of select="view/trailers/title"/></title>
                <style type="text/css">
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                        color: #333;
                        background-color: #f4f4f4;
                    }
                    h1 {
                        color: #0073e6;
                        font-size: 2em;
                        margin-bottom: 20px;
                    }
                    .container {
                        width: 80%;
                        margin: 0 auto;
                        background: #fff;
                        padding: 20px;
                        box-shadow: 0 0 10px rgba(0,0,0,0.1);
                        border-radius: 5px;
                    }
                    .top-section {
                        margin-bottom: 20px;
                    }
                    .top-section img {
                        max-width: 500px;
                        height: auto;
                        display: block;
                        margin: 0 auto;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 20px;
                    }
                    table, th, td {
                        border: 1px solid #ddd;
                    }
                    th, td {
                        padding: 8px;
                        text-align: left;
                        font-size: 0.9em;
                    }
                    th {
                        background-color: #f4f4f4;
                        color: #333;
                    }
                    td a {
                        color: #0073e6;
                        text-decoration: none;
                    }
                    td a:hover {
                        text-decoration: underline;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="top-section">
                        <h1><xsl:value-of select="view/trailers/title"/></h1>
                        <p><strong>Author:</strong> <xsl:value-of select="view/trailers/author"/></p>
                        <p><strong>Description:</strong> <xsl:value-of select="view/trailers/description"/></p>
                        <p><strong>Language:</strong> <xsl:value-of select="view/trailers/language"/></p>
                        <p><strong>Format:</strong> <xsl:value-of select="view/trailers/format"/></p>
                        <p><strong>Category:</strong> <xsl:value-of select="view/trailers/category/@text"/></p>
                        <img src="{view/trailers/image/@href}" alt="Trailer Image"/>
                    </div>
                    
                    <table>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Released</th>
                                <th>Duration</th>
                                <th>Video</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="view/trailers/item">
                                <tr>
                                    <td><xsl:value-of select="title"/></td>
                                    <td><xsl:value-of select="description"/></td>
                                    <td><xsl:value-of select="released"/></td>
                                    <td><xsl:value-of select="duration"/></td>
                                    <td><a href="{enclosure/@url}">Watch Trailer</a></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
