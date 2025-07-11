
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8" />
        <title>Test Select</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>

        <select id="provinceSelect"></select>

        <script>
            let provinces = [];
            $(document).ready(function () {
                const url = '${pageContext.request.contextPath}/assets/VietNam.json';
                $.getJSON(url, function (data) {
                    provinces = data;
                    console.log("1. Data:", provinces);

                    $('#provinceSelect').empty().append('<option value="">-- Ch?n T?nh/TP --</option>');

                    provinces.forEach(function (province) {
                        console.log("2. Province:", province);
                        $('#provinceSelect').append(`<option value="${province.name}">${province.name}</option>`);
                    });
                });
            });
        </script>


    </body>
</html>
